import SwiftUI
import FluxComponentsKit

struct FluxBottomSheetShowcase: View {
    @StateObject private var sheetVM = FluxBottomSheetViewModel(title: "Bottom Sheet")
    @State private var toastMessage: String?

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: FluxSpacing.lg) {
                    section("Open Sheet") {
                        sheetButton("Small (25%)") { sheetVM.detent = .small; sheetVM.isPresented = true }
                        sheetButton("Medium (50%)") { sheetVM.detent = .medium; sheetVM.isPresented = true }
                        sheetButton("Large (85%)") { sheetVM.detent = .large; sheetVM.isPresented = true }
                    }
                    usageSection
                }
                .padding(FluxSpacing.md)
            }
            .navigationTitle("FluxBottomSheet")

            FluxBottomSheet(viewModel: sheetVM) {
                VStack(alignment: .leading, spacing: FluxSpacing.md) {
                    FluxText("Sheet Content", style: .headline)
                    FluxText("This is a custom bottom sheet component. You can drag it down to dismiss or tap the close button.", style: .body, color: FluxColors.textSecondary)

                    ForEach(1..<6) { i in
                        HStack(spacing: FluxSpacing.sm) {
                            FluxIcon("\(i).circle.fill", size: .medium, color: FluxColors.primary)
                            FluxText("Item \(i)", style: .body)
                            Spacer()
                        }
                        .padding(FluxSpacing.sm)
                        .background(FluxColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if let toast = toastMessage {
                FluxText(toast, style: .footnote, color: .white)
                    .padding(.horizontal, FluxSpacing.md)
                    .padding(.vertical, FluxSpacing.sm)
                    .background(FluxColors.secondary.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.bottom, FluxSpacing.xl)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: toastMessage)
        .onAppear { sheetVM.onDismiss = { showToast("Sheet dismissed") } }
    }

    private func sheetButton(_ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            FluxText(label, style: .body, color: .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, FluxSpacing.sm)
                .background(FluxColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: FluxRadius.md))
        }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxBottomSheetViewModel(
                title: "Title",
                detent: .medium,
                onDismiss: { print("dismissed") }
            )

            ZStack {
                YourContent()
                FluxBottomSheet(viewModel: vm) {
                    Text("Sheet content")
                }
            }

            vm.isPresented = true
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: FluxSpacing.sm) {
            FluxText(title, style: .headline)
            content()
        }
    }
}

import SwiftUI
import FluxComponentsKit

struct FluxImageShowcase: View {
    @StateObject private var systemVM = FluxImageViewModel(source: .system("photo.artframe"), size: .large)
    @StateObject private var urlVM = FluxImageViewModel(
        source: .url(URL(string: "https://picsum.photos/200")!),
        size: .large,
        contentMode: .fill,
        cornerRadius: FluxRadius.md
    )
    @State private var toastMessage: String?
    @State private var selectedSize = 1

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("System Image (SF Symbol)") {
                    HStack(spacing: FluxSpacing.md) {
                        FluxImage(systemName: "star.fill", size: .small)
                        FluxImage(systemName: "heart.fill", size: .medium)
                        FluxImage(systemName: "bolt.fill", size: .large)
                    }
                }

                section("Sizes") {
                    Picker("Size", selection: $selectedSize) {
                        FluxText("Small", style: .caption).tag(0)
                        FluxText("Medium", style: .caption).tag(1)
                        FluxText("Large", style: .caption).tag(2)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedSize) { newValue in
                        switch newValue {
                        case 0: systemVM.size = .small
                        case 1: systemVM.size = .medium
                        case 2: systemVM.size = .large
                        default: break
                        }
                    }

                    FluxImage(viewModel: systemVM)
                        .padding(FluxSpacing.md)
                        .frame(maxWidth: .infinity)
                        .background(FluxColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.md))
                }

                section("Clickable Image") {
                    FluxImage(systemName: "hand.tap.fill", size: .large, onTap: {
                        showToast("Image tapped!")
                    })
                    .padding(FluxSpacing.md)
                    .frame(maxWidth: .infinity)
                    .background(FluxColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.md))

                    FluxText("Tap the image above", style: .footnote, color: FluxColors.textSecondary)
                }

                section("URL Image (AsyncImage)") {
                    FluxImage(viewModel: urlVM)
                        .padding(FluxSpacing.md)
                        .frame(maxWidth: .infinity)
                        .background(FluxColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.md))

                    FluxText("Loads from picsum.photos", style: .footnote, color: FluxColors.textSecondary)
                }

                section("With Border & Corner Radius") {
                    HStack(spacing: FluxSpacing.md) {
                        FluxImage(viewModel: {
                            let vm = FluxImageViewModel(source: .system("person.crop.circle.fill"), size: .medium, cornerRadius: FluxRadius.lg, borderColor: FluxColors.primary, borderWidth: 2)
                            return vm
                        }())

                        FluxImage(viewModel: {
                            let vm = FluxImageViewModel(source: .system("globe"), size: .medium, cornerRadius: FluxRadius.sm, borderColor: FluxColors.accent, borderWidth: 2)
                            return vm
                        }())

                        FluxImage(viewModel: {
                            let vm = FluxImageViewModel(source: .system("leaf.fill"), size: .medium, cornerRadius: 40, borderColor: FluxColors.success, borderWidth: 3)
                            return vm
                        }())
                    }
                    .frame(maxWidth: .infinity)
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxImage")
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
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // System image (SF Symbol)
            FluxImage(systemName: "star.fill", size: .medium)

            // URL image with async loading
            FluxImage(url: myURL, size: .large, cornerRadius: 12)

            // Asset image
            FluxImage(asset: "myPhoto", size: .custom(100))

            // Clickable with ViewModel
            @StateObject var vm = FluxImageViewModel(
                source: .system("heart.fill"),
                size: .large,
                cornerRadius: 8,
                borderColor: .blue,
                borderWidth: 2,
                onTap: { print("tapped") }
            )
            FluxImage(viewModel: vm)
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

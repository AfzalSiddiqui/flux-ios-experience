import SwiftUI
import FluxComponentsKit

struct FluxAlertViewShowcase: View {
    @StateObject private var infoVM = FluxAlertViewViewModel(variant: .info, title: "Info", message: "This is an informational alert.")
    @StateObject private var successVM = FluxAlertViewViewModel(variant: .success, title: "Success", message: "Operation completed successfully.")
    @StateObject private var warningVM = FluxAlertViewViewModel(variant: .warning, title: "Warning", message: "Please review before proceeding.")
    @StateObject private var errorVM = FluxAlertViewViewModel(variant: .error, title: "Error", message: "Something went wrong. Please try again.")

    @State private var toastMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("Info") { FluxAlertView(viewModel: infoVM) }
                section("Success") { FluxAlertView(viewModel: successVM) }
                section("Warning") { FluxAlertView(viewModel: warningVM) }
                section("Error") { FluxAlertView(viewModel: errorVM) }

                Button("Reset All") {
                    infoVM.isVisible = true; successVM.isVisible = true
                    warningVM.isVisible = true; errorVM.isVisible = true
                }
                .font(FluxFont.body)
                .foregroundStyle(FluxColors.primary)

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxAlertView")
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
        .onAppear { setupActions() }
    }

    private func setupActions() {
        infoVM.onDismiss = { showToast("Info dismissed") }
        successVM.onDismiss = { showToast("Success dismissed") }
        warningVM.onDismiss = { showToast("Warning dismissed") }
        errorVM.onDismiss = { showToast("Error dismissed") }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxAlertViewViewModel(
                variant: .success,
                title: "Success",
                message: "Done!",
                isDismissible: true,
                onDismiss: { print("dismissed") }
            )

            FluxAlertView(viewModel: vm)
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

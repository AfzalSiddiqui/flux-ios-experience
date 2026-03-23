import SwiftUI
import flux_ios_foundation

struct FluxButtonShowcase: View {
    @StateObject private var primaryVM = FluxButtonViewModel(title: "Primary Button", variant: .primary)
    @StateObject private var secondaryVM = FluxButtonViewModel(title: "Secondary Button", variant: .secondary)
    @StateObject private var destructiveVM = FluxButtonViewModel(title: "Destructive Button", variant: .destructive)

    @StateObject private var smallVM = FluxButtonViewModel(title: "Small", size: .small)
    @StateObject private var mediumVM = FluxButtonViewModel(title: "Medium", size: .medium)
    @StateObject private var largeVM = FluxButtonViewModel(title: "Large", size: .large)

    @StateObject private var loadingVM = FluxButtonViewModel(title: "Loading...", isLoading: true)
    @StateObject private var disabledVM = FluxButtonViewModel(title: "Disabled", isDisabled: true)

    // Action feedback state
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var tapCount = 0
    @State private var toastMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                // Tap counter feedback
                if tapCount > 0 {
                    FluxText("Tapped \(tapCount) time\(tapCount == 1 ? "" : "s")", style: .callout, color: FluxColors.success)
                        .frame(maxWidth: .infinity)
                        .padding(FluxSpacing.sm)
                        .background(FluxColors.success.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
                }

                section("Variants") {
                    FluxButton(viewModel: primaryVM)
                    FluxButton(viewModel: secondaryVM)
                    FluxButton(viewModel: destructiveVM)
                }

                section("Sizes") {
                    FluxButton(viewModel: smallVM)
                    FluxButton(viewModel: mediumVM)
                    FluxButton(viewModel: largeVM)
                }

                section("States") {
                    FluxButton(viewModel: loadingVM)
                    FluxButton(viewModel: disabledVM)
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxButton")
        .alert("Button Action", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
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
        .onAppear { setupActions() }
    }

    private func setupActions() {
        primaryVM.action = {
            tapCount += 1
            alertMessage = "Primary button tapped! (tap #\(tapCount))"
            showAlert = true
        }
        secondaryVM.action = {
            tapCount += 1
            showToast("Secondary tapped")
        }
        destructiveVM.action = {
            tapCount += 1
            alertMessage = "Destructive action triggered! Are you sure?"
            showAlert = true
        }
        smallVM.action = { tapCount += 1; showToast("Small tapped") }
        mediumVM.action = { tapCount += 1; showToast("Medium tapped") }
        largeVM.action = { tapCount += 1; showToast("Large tapped") }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toastMessage = nil
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxButtonViewModel(
                title: "Save",
                variant: .primary,
                size: .medium,
                action: { print("Saved!") }
            )

            // 2. Pass it to the View
            FluxButton(viewModel: vm)

            // 3. Update state dynamically
            vm.isLoading = true
            vm.title = "Saving..."
            vm.isDisabled = true
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

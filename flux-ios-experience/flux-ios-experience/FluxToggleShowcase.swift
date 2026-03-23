import SwiftUI
import flux_ios_foundation

struct FluxToggleShowcase: View {
    @StateObject private var smallVM = FluxToggleViewModel(isOn: false, label: "Small Toggle", size: .small)
    @StateObject private var mediumVM = FluxToggleViewModel(isOn: true, label: "Medium Toggle", size: .medium)
    @StateObject private var largeVM = FluxToggleViewModel(isOn: false, label: "Large Toggle", size: .large)
    @StateObject private var colorVM = FluxToggleViewModel(isOn: true, label: "Custom Color", tintColor: FluxColors.success)
    @StateObject private var disabledVM = FluxToggleViewModel(isOn: false, label: "Disabled", isDisabled: true)

    @State private var toastMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("Sizes") {
                    FluxToggle(viewModel: smallVM)
                    FluxToggle(viewModel: mediumVM)
                    FluxToggle(viewModel: largeVM)
                }
                section("Custom Color") {
                    FluxToggle(viewModel: colorVM)
                }
                section("States") {
                    FluxToggle(viewModel: disabledVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxToggle")
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
        smallVM.onToggle = { val in showToast("Small: \(val ? "ON" : "OFF")") }
        mediumVM.onToggle = { val in showToast("Medium: \(val ? "ON" : "OFF")") }
        largeVM.onToggle = { val in showToast("Large: \(val ? "ON" : "OFF")") }
        colorVM.onToggle = { val in showToast("Color: \(val ? "ON" : "OFF")") }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxToggleViewModel(
                isOn: false,
                label: "Notifications",
                size: .medium,
                tintColor: FluxColors.primary,
                onToggle: { isOn in print(isOn) }
            )

            FluxToggle(viewModel: vm)
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

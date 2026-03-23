import SwiftUI
import flux_ios_foundation

struct FluxCheckBoxShowcase: View {
    @StateObject private var filledVM = FluxCheckBoxViewModel(label: "Filled Style", style: .filled)
    @StateObject private var outlinedVM = FluxCheckBoxViewModel(label: "Outlined Style", style: .outlined)
    @StateObject private var smallVM = FluxCheckBoxViewModel(label: "Small", size: .small)
    @StateObject private var mediumVM = FluxCheckBoxViewModel(label: "Medium", size: .medium)
    @StateObject private var largeVM = FluxCheckBoxViewModel(label: "Large", size: .large)
    @StateObject private var colorVM = FluxCheckBoxViewModel(label: "Custom Color", color: FluxColors.success)
    @StateObject private var disabledVM = FluxCheckBoxViewModel(isChecked: true, label: "Disabled", isDisabled: true)

    @State private var checkedCount = 0

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText("Checked: \(checkedCount)", style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("Styles") {
                    FluxCheckBox(viewModel: filledVM)
                    FluxCheckBox(viewModel: outlinedVM)
                }
                section("Sizes") {
                    FluxCheckBox(viewModel: smallVM)
                    FluxCheckBox(viewModel: mediumVM)
                    FluxCheckBox(viewModel: largeVM)
                }
                section("Custom & Disabled") {
                    FluxCheckBox(viewModel: colorVM)
                    FluxCheckBox(viewModel: disabledVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxCheckBox")
        .onAppear { setupActions() }
    }

    private func setupActions() {
        let allVMs = [filledVM, outlinedVM, smallVM, mediumVM, largeVM, colorVM]
        for vm in allVMs {
            vm.onToggle = { _ in checkedCount = allVMs.filter(\.isChecked).count }
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxCheckBoxViewModel(
                isChecked: false,
                label: "Accept Terms",
                style: .filled,
                size: .medium,
                onToggle: { checked in print(checked) }
            )

            FluxCheckBox(viewModel: vm)
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

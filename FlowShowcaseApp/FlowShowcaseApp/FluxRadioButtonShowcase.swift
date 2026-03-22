import SwiftUI
import FluxComponentsKit

struct FluxRadioButtonShowcase: View {
    @StateObject private var option1VM = FluxRadioButtonViewModel(label: "Option A", isSelected: true)
    @StateObject private var option2VM = FluxRadioButtonViewModel(label: "Option B")
    @StateObject private var option3VM = FluxRadioButtonViewModel(label: "Option C")
    @StateObject private var smallVM = FluxRadioButtonViewModel(label: "Small", size: .small)
    @StateObject private var mediumVM = FluxRadioButtonViewModel(label: "Medium", size: .medium)
    @StateObject private var largeVM = FluxRadioButtonViewModel(label: "Large", size: .large)
    @StateObject private var disabledVM = FluxRadioButtonViewModel(label: "Disabled", isDisabled: true)

    @State private var selectionBanner: String = "Selected: Option A"

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText(selectionBanner, style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("Radio Group") {
                    FluxRadioButton(viewModel: option1VM)
                    FluxRadioButton(viewModel: option2VM)
                    FluxRadioButton(viewModel: option3VM)
                }
                section("Sizes") {
                    FluxRadioButton(viewModel: smallVM)
                    FluxRadioButton(viewModel: mediumVM)
                    FluxRadioButton(viewModel: largeVM)
                }
                section("States") {
                    FluxRadioButton(viewModel: disabledVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxRadioButton")
        .onAppear { setupActions() }
    }

    private func setupActions() {
        let allGroupVMs = [option1VM, option2VM, option3VM]
        for (index, vm) in allGroupVMs.enumerated() {
            vm.onSelect = { [weak option1VM, weak option2VM, weak option3VM] in
                let vms = [option1VM, option2VM, option3VM].compactMap { $0 }
                for (i, v) in vms.enumerated() { v.isSelected = (i == index) }
                selectionBanner = "Selected: \(vm.label)"
            }
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxRadioButtonViewModel(
                label: "Option A",
                isSelected: false,
                size: .medium,
                onSelect: { print("Selected") }
            )

            FluxRadioButton(viewModel: vm)
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

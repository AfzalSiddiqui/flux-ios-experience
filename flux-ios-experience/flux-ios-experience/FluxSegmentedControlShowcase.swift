import SwiftUI
import flux_ios_foundation

struct FluxSegmentedControlShowcase: View {
    @StateObject private var twoItemVM = FluxSegmentedControlViewModel(items: ["Left", "Right"])
    @StateObject private var threeItemVM = FluxSegmentedControlViewModel(items: ["Day", "Week", "Month"])
    @StateObject private var fourItemVM = FluxSegmentedControlViewModel(items: ["Q1", "Q2", "Q3", "Q4"])
    @StateObject private var filledVM = FluxSegmentedControlViewModel(items: ["Filled A", "Filled B"], style: .filled)
    @StateObject private var outlinedVM = FluxSegmentedControlViewModel(items: ["Outlined A", "Outlined B"], style: .outlined)
    @StateObject private var disabledVM = FluxSegmentedControlViewModel(items: ["A", "B", "C"], isDisabled: true)

    @State private var selectionText = "Selected index: 0"

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText(selectionText, style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("2 Items") { FluxSegmentedControl(viewModel: twoItemVM) }
                section("3 Items") { FluxSegmentedControl(viewModel: threeItemVM) }
                section("4 Items") { FluxSegmentedControl(viewModel: fourItemVM) }
                section("Styles") {
                    FluxSegmentedControl(viewModel: filledVM)
                    FluxSegmentedControl(viewModel: outlinedVM)
                }
                section("Disabled") { FluxSegmentedControl(viewModel: disabledVM) }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxSegmentedControl")
        .onAppear { setupActions() }
    }

    private func setupActions() {
        let allVMs = [twoItemVM, threeItemVM, fourItemVM, filledVM, outlinedVM]
        for vm in allVMs {
            vm.onSelectionChanged = { index in
                selectionText = "Selected: \(vm.items[index]) (index \(index))"
            }
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxSegmentedControlViewModel(
                items: ["Day", "Week", "Month"],
                selectedIndex: 0,
                style: .filled,
                onSelectionChanged: { index in print(index) }
            )

            FluxSegmentedControl(viewModel: vm)
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

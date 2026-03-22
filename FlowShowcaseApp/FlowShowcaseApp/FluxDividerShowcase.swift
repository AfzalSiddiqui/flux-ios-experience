import SwiftUI
import FluxComponentsKit

struct FluxDividerShowcase: View {
    @StateObject private var horizontalVM = FluxDividerViewModel()
    @StateObject private var coloredVM = FluxDividerViewModel(color: FluxColors.primary)
    @StateObject private var verticalVM = FluxDividerViewModel(axis: .vertical)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                FluxText("Horizontal", style: .headline)
                FluxDivider(viewModel: horizontalVM)

                FluxText("Custom Color", style: .headline)
                FluxDivider(viewModel: coloredVM)

                FluxText("Vertical", style: .headline)
                HStack(spacing: FluxSpacing.md) {
                    FluxText("Left", style: .body)
                    FluxDivider(viewModel: verticalVM)
                        .frame(height: 40)
                    FluxText("Right", style: .body)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxDivider")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // Horizontal divider (default)
            @StateObject var vm = FluxDividerViewModel()
            FluxDivider(viewModel: vm)

            // Vertical divider
            @StateObject var vVM = FluxDividerViewModel(
                axis: .vertical
            )
            FluxDivider(viewModel: vVM)
                .frame(height: 40)

            // Custom color
            @StateObject var cVM = FluxDividerViewModel(
                color: FluxColors.primary
            )
            FluxDivider(viewModel: cVM)
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

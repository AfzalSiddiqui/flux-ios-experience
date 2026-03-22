import SwiftUI
import FluxComponentsKit

struct FluxDividerShowcase: View {
    @StateObject private var horizontalVM = FluxDividerViewModel()
    @StateObject private var coloredVM = FluxDividerViewModel(color: FluxColors.primary)
    @StateObject private var verticalVM = FluxDividerViewModel(axis: .vertical)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                Text("Horizontal").font(FluxFont.headline)
                FluxDivider(viewModel: horizontalVM)

                Text("Custom Color").font(FluxFont.headline)
                FluxDivider(viewModel: coloredVM)

                Text("Vertical").font(FluxFont.headline)
                HStack(spacing: FluxSpacing.md) {
                    Text("Left").font(FluxFont.body)
                    FluxDivider(viewModel: verticalVM)
                        .frame(height: 40)
                    Text("Right").font(FluxFont.body)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxDivider")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
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
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

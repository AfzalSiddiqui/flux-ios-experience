import SwiftUI
import flux_ios_foundation

struct FluxBoxGridShowcase: View {
    @StateObject private var threeColVM = FluxBoxGridViewModel(
        items: [
            FluxBoxGridItem(icon: .system("house.fill"), label: "Home", color: FluxColors.primary),
            FluxBoxGridItem(icon: .system("heart.fill"), label: "Health", color: FluxColors.error),
            FluxBoxGridItem(icon: .system("cart.fill"), label: "Shop", color: FluxColors.success),
            FluxBoxGridItem(icon: .system("book.fill"), label: "Learn", color: FluxColors.warning),
            FluxBoxGridItem(icon: .system("gamecontroller.fill"), label: "Games", color: FluxColors.accent),
            FluxBoxGridItem(icon: .system("music.note"), label: "Music", color: FluxColors.primary)
        ],
        columns: 3, selectionMode: .single, selectedIndices: [0], itemSize: .medium
    )
    @StateObject private var fourColVM = FluxBoxGridViewModel(
        items: [
            FluxBoxGridItem(icon: .system("sun.max.fill"), label: "Sun"),
            FluxBoxGridItem(icon: .system("moon.fill"), label: "Moon"),
            FluxBoxGridItem(icon: .system("cloud.fill"), label: "Cloud"),
            FluxBoxGridItem(icon: .system("bolt.fill"), label: "Storm"),
            FluxBoxGridItem(icon: .system("snow"), label: "Snow"),
            FluxBoxGridItem(icon: .system("wind"), label: "Wind"),
            FluxBoxGridItem(icon: .system("drop.fill"), label: "Rain"),
            FluxBoxGridItem(icon: .system("thermometer.medium"), label: "Temp")
        ],
        columns: 4, selectionMode: .multi, itemSize: .small
    )

    @State private var selectionText = "Selected: {0}"

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText(selectionText, style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("3 Columns (Single Select)") { FluxBoxGrid(viewModel: threeColVM) }
                section("4 Columns (Multi Select)") { FluxBoxGrid(viewModel: fourColVM) }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxBoxGrid")
        .onAppear { setupActions() }
    }

    private func setupActions() {
        threeColVM.onSelectionChanged = { indices in selectionText = "3-col: \(indices.sorted())" }
        fourColVM.onSelectionChanged = { indices in selectionText = "4-col: \(indices.sorted())" }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxBoxGridViewModel(
                items: [
                    FluxBoxGridItem(icon: "star", label: "Star"),
                    FluxBoxGridItem(icon: "heart", label: "Heart")
                ],
                columns: 3,
                selectionMode: .single,
                itemSize: .medium,
                onSelectionChanged: { indices in print(indices) }
            )

            FluxBoxGrid(viewModel: vm)
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

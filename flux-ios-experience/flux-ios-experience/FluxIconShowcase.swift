import SwiftUI
import flux_ios_foundation

struct FluxIconShowcase: View {
    @StateObject private var smallVM = FluxIconViewModel(systemName: "star.fill", size: .small, color: FluxColors.primary)
    @StateObject private var mediumVM = FluxIconViewModel(systemName: "star.fill", size: .medium, color: FluxColors.primary)
    @StateObject private var largeVM = FluxIconViewModel(systemName: "star.fill", size: .large, color: FluxColors.primary)

    @StateObject private var heartVM = FluxIconViewModel(systemName: "heart.fill", color: FluxColors.error)
    @StateObject private var bellVM = FluxIconViewModel(systemName: "bell.fill", color: FluxColors.warning)
    @StateObject private var gearVM = FluxIconViewModel(systemName: "gear", color: FluxColors.textSecondary)
    @StateObject private var personVM = FluxIconViewModel(systemName: "person.fill", color: FluxColors.primary)
    @StateObject private var houseVM = FluxIconViewModel(systemName: "house.fill", color: FluxColors.success)
    @StateObject private var checkVM = FluxIconViewModel(systemName: "checkmark.circle.fill", color: FluxColors.accent)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                FluxText("Sizes", style: .headline)
                HStack(spacing: FluxSpacing.xl) {
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: smallVM)
                        FluxText("Small", style: .caption)
                    }
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: mediumVM)
                        FluxText("Medium", style: .caption)
                    }
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: largeVM)
                        FluxText("Large", style: .caption)
                    }
                }

                FluxText("Gallery", style: .headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 72))], spacing: FluxSpacing.md) {
                    iconTile(heartVM, label: "heart.fill")
                    iconTile(bellVM, label: "bell.fill")
                    iconTile(gearVM, label: "gear")
                    iconTile(personVM, label: "person.fill")
                    iconTile(houseVM, label: "house.fill")
                    iconTile(checkVM, label: "checkmark")
                }

                FluxText("URL Icon", style: .headline)
                HStack(spacing: FluxSpacing.xl) {
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(url: URL(string: "https://picsum.photos/64")!, size: .large)
                        FluxText("URL", style: .caption)
                    }
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxIcon")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxIconViewModel(
                systemName: "star.fill",
                size: .medium,
                color: FluxColors.primary
            )

            // 2. Pass it to the View
            FluxIcon(viewModel: vm)

            // 3. Update dynamically
            vm.systemName = "heart.fill"
            vm.color = FluxColors.error
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }

    private func iconTile(_ vm: FluxIconViewModel, label: String) -> some View {
        VStack(spacing: FluxSpacing.xs) {
            FluxIcon(viewModel: vm)
            FluxText(label, style: .caption)
        }
    }
}

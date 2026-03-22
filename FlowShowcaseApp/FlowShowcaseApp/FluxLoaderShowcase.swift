import SwiftUI
import FluxComponentsKit

struct FluxLoaderShowcase: View {
    @StateObject private var smallVM = FluxLoaderViewModel(size: .small)
    @StateObject private var mediumVM = FluxLoaderViewModel(size: .medium)
    @StateObject private var largeVM = FluxLoaderViewModel(size: .large)

    @StateObject private var primaryTintVM = FluxLoaderViewModel(tint: FluxColors.primary)
    @StateObject private var successTintVM = FluxLoaderViewModel(tint: FluxColors.success)
    @StateObject private var errorTintVM = FluxLoaderViewModel(tint: FluxColors.error)

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.xl) {
                FluxText("Sizes", style: .headline)
                HStack(spacing: FluxSpacing.xxl) {
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: smallVM)
                        FluxText("Small", style: .caption)
                    }
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: mediumVM)
                        FluxText("Medium", style: .caption)
                    }
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: largeVM)
                        FluxText("Large", style: .caption)
                    }
                }

                FluxText("Tint Colors", style: .headline)
                HStack(spacing: FluxSpacing.xxl) {
                    FluxLoader(viewModel: primaryTintVM)
                    FluxLoader(viewModel: successTintVM)
                    FluxLoader(viewModel: errorTintVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxLoader")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxLoaderViewModel(
                size: .medium,
                tint: FluxColors.primary
            )

            // 2. Pass it to the View
            FluxLoader(viewModel: vm)

            // 3. Update dynamically
            vm.size = .large
            vm.tint = FluxColors.success
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

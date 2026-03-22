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
                Text("Sizes").font(FluxFont.headline)
                HStack(spacing: FluxSpacing.xxl) {
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: smallVM)
                        Text("Small").font(FluxFont.caption).foregroundStyle(FluxColors.textSecondary)
                    }
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: mediumVM)
                        Text("Medium").font(FluxFont.caption).foregroundStyle(FluxColors.textSecondary)
                    }
                    VStack(spacing: FluxSpacing.sm) {
                        FluxLoader(viewModel: largeVM)
                        Text("Large").font(FluxFont.caption).foregroundStyle(FluxColors.textSecondary)
                    }
                }

                Text("Tint Colors").font(FluxFont.headline)
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
            Text("How to Use").font(FluxFont.headline)
            Text("""
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
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

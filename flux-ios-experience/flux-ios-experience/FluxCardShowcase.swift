import SwiftUI
import flux_ios_foundation

struct FluxCardShowcase: View {
    @StateObject private var smallShadowVM = FluxCardViewModel(shadow: .small)
    @StateObject private var mediumShadowVM = FluxCardViewModel(shadow: .medium)
    @StateObject private var largeShadowVM = FluxCardViewModel(shadow: .large)
    @StateObject private var customVM = FluxCardViewModel(padding: FluxSpacing.lg, cornerRadius: FluxRadius.xl, shadow: .medium)

    // Atoms used inside cards
    @StateObject private var titleVM = FluxTextViewModel(content: "Card Title", style: .headline)
    @StateObject private var bodyVM = FluxTextViewModel(content: "Default padding, corner radius, and small shadow.", style: .body, color: FluxColors.textSecondary)
    @StateObject private var cardIconVM = FluxIconViewModel(systemName: "creditcard.fill", size: .large, color: FluxColors.primary)
    @StateObject private var cardTitleVM = FluxTextViewModel(content: "Payment Card", style: .headline)
    @StateObject private var cardSubtitleVM = FluxTextViewModel(content: "**** 4242", style: .caption)
    @StateObject private var starVM = FluxIconViewModel(systemName: "star.fill", size: .medium, color: FluxColors.warning)
    @StateObject private var featureTextVM = FluxTextViewModel(content: "Featured Content", style: .title3)
    @StateObject private var featureBodyVM = FluxTextViewModel(content: "Large padding, extra-round corners, and medium shadow.", style: .footnote)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                FluxText("Small Shadow", style: .headline)
                FluxCard(viewModel: smallShadowVM) {
                    VStack(alignment: .leading, spacing: FluxSpacing.xs) {
                        FluxText(viewModel: titleVM)
                        FluxText(viewModel: bodyVM)
                    }
                }

                FluxText("Medium Shadow", style: .headline)
                FluxCard(viewModel: mediumShadowVM) {
                    HStack(spacing: FluxSpacing.sm) {
                        FluxIcon(viewModel: cardIconVM)
                        VStack(alignment: .leading, spacing: FluxSpacing.xxxs) {
                            FluxText(viewModel: cardTitleVM)
                            FluxText(viewModel: cardSubtitleVM)
                        }
                    }
                }

                FluxText("Custom Styling", style: .headline)
                FluxCard(viewModel: customVM) {
                    HStack(spacing: FluxSpacing.sm) {
                        FluxIcon(viewModel: starVM)
                        VStack(alignment: .leading, spacing: FluxSpacing.xxxs) {
                            FluxText(viewModel: featureTextVM)
                            FluxText(viewModel: featureBodyVM)
                        }
                    }
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxCard")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxCardViewModel(
                padding: FluxSpacing.md,
                cornerRadius: FluxRadius.md,
                shadow: .medium
            )

            // 2. Pass it with content
            FluxCard(viewModel: vm) {
                // Any SwiftUI content inside
                FluxText(viewModel: titleVM)
                FluxIcon(viewModel: iconVM)
            }

            // 3. Update dynamically
            vm.shadow = .large
            vm.cornerRadius = FluxRadius.xl
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

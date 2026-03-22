import SwiftUI
import FluxComponentsKit

struct FluxInfoViewShowcase: View {
    @StateObject private var horizontalVM = FluxInfoViewModel(
        icon: .system("info.circle.fill"), iconColor: FluxColors.primary,
        title: "Information", description: "This is a horizontal info view with an icon and description.", alignment: .horizontal
    )
    @StateObject private var verticalVM = FluxInfoViewModel(
        icon: .system("star.fill"), iconColor: FluxColors.warning,
        title: "Featured", description: "This is a vertically aligned info view centered on the card.", alignment: .vertical
    )
    @StateObject private var successVM = FluxInfoViewModel(
        icon: .system("checkmark.circle.fill"), iconColor: FluxColors.success,
        title: "Success", description: "Your operation completed successfully.", alignment: .horizontal
    )
    @StateObject private var errorVM = FluxInfoViewModel(
        icon: .system("xmark.circle.fill"), iconColor: FluxColors.error,
        title: "Error", description: "Something went wrong. Please try again.", alignment: .horizontal
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                section("Horizontal") {
                    FluxInfoView(viewModel: horizontalVM)
                    FluxInfoView(viewModel: successVM)
                    FluxInfoView(viewModel: errorVM)
                }
                section("Vertical") {
                    FluxInfoView(viewModel: verticalVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxInfoView")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxInfoViewModel(
                icon: "info.circle.fill",
                iconColor: FluxColors.primary,
                title: "Title",
                description: "Description text",
                alignment: .horizontal
            )

            FluxInfoView(viewModel: vm)
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

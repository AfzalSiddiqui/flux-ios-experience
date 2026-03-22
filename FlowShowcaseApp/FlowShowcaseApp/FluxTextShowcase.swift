import SwiftUI
import FluxComponentsKit

struct FluxTextShowcase: View {
    @StateObject private var largeTitleVM = FluxTextViewModel(content: "Large Title", style: .largeTitle)
    @StateObject private var titleVM = FluxTextViewModel(content: "Title", style: .title)
    @StateObject private var title2VM = FluxTextViewModel(content: "Title 2", style: .title2)
    @StateObject private var title3VM = FluxTextViewModel(content: "Title 3", style: .title3)
    @StateObject private var headlineVM = FluxTextViewModel(content: "Headline", style: .headline)
    @StateObject private var subheadlineVM = FluxTextViewModel(content: "Subheadline", style: .subheadline)
    @StateObject private var bodyVM = FluxTextViewModel(content: "Body text for content", style: .body)
    @StateObject private var calloutVM = FluxTextViewModel(content: "Callout", style: .callout)
    @StateObject private var footnoteVM = FluxTextViewModel(content: "Footnote", style: .footnote)
    @StateObject private var captionVM = FluxTextViewModel(content: "Caption", style: .caption)
    @StateObject private var customColorVM = FluxTextViewModel(content: "Custom Color Text", style: .body, color: FluxColors.accent)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.sm) {
                FluxText("All Styles", style: .headline)

                FluxText(viewModel: largeTitleVM)
                FluxText(viewModel: titleVM)
                FluxText(viewModel: title2VM)
                FluxText(viewModel: title3VM)
                FluxText(viewModel: headlineVM)
                FluxText(viewModel: subheadlineVM)
                FluxText(viewModel: bodyVM)
                FluxText(viewModel: calloutVM)
                FluxText(viewModel: footnoteVM)
                FluxText(viewModel: captionVM)

                Spacer().frame(height: FluxSpacing.md)
                FluxText("Custom Color", style: .headline)
                FluxText(viewModel: customColorVM)

                Spacer().frame(height: FluxSpacing.md)
                usageSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxText")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxTextViewModel(
                content: "Hello World",
                style: .headline,
                color: FluxColors.primary
            )

            // 2. Pass it to the View
            FluxText(viewModel: vm)

            // 3. Update dynamically
            vm.content = "Updated!"
            vm.style = .title
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

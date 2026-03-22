import SwiftUI
import FluxComponentsKit

struct FluxAttributedTextShowcase: View {
    @StateObject private var plainVM = FluxTextViewModel(
        content: "This is plain text rendered with FluxText styling.",
        style: .body
    )

    @StateObject private var boldItalicVM = FluxTextViewModel(
        segments: [
            FluxTextSegment(text: "This is "),
            FluxTextSegment(text: "bold", isBold: true),
            FluxTextSegment(text: " and "),
            FluxTextSegment(text: "italic", isItalic: true),
            FluxTextSegment(text: " and "),
            FluxTextSegment(text: "colored", color: FluxColors.primary),
            FluxTextSegment(text: " text.")
        ],
        style: .body
    )

    @StateObject private var decoratedVM = FluxTextViewModel(
        segments: [
            FluxTextSegment(text: "Underlined", isUnderline: true),
            FluxTextSegment(text: " and "),
            FluxTextSegment(text: "strikethrough", isStrikethrough: true),
            FluxTextSegment(text: " text styles.")
        ],
        style: .body
    )

    @StateObject private var linkVM = FluxTextViewModel(
        segments: [
            FluxTextSegment(text: "Visit "),
            FluxTextSegment(text: "Apple", color: FluxColors.primary, link: URL(string: "https://apple.com")),
            FluxTextSegment(text: " for more info.")
        ],
        style: .body
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                section("Plain Mode") {
                    FluxText(viewModel: plainVM)
                }
                section("Bold, Italic & Color") {
                    FluxText(viewModel: boldItalicVM)
                }
                section("Underline & Strikethrough") {
                    FluxText(viewModel: decoratedVM)
                }
                section("Links") {
                    FluxText(viewModel: linkVM)
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxAttributedText")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // Plain mode
            FluxText("Hello World", style: .body)

            // Attributed mode via ViewModel
            let vm = FluxTextViewModel(
                segments: [
                    FluxTextSegment(text: "Bold", isBold: true),
                    FluxTextSegment(text: " normal")
                ],
                style: .body
            )
            FluxText(viewModel: vm)

            // Attributed mode via convenience
            FluxText(segments: [
                FluxTextSegment(text: "Bold", isBold: true)
            ], style: .body)
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

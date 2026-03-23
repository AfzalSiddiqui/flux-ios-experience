import SwiftUI
import flux_ios_foundation

struct FluxCardFlapShowcase: View {
    @StateObject private var cardVM = FluxCardFlapViewModel(shadow: .medium, flipDuration: 0.6)
    @State private var statusText = "Showing: Front"

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText(statusText, style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("Credit Card Flip") {
                    FluxCardFlap(viewModel: cardVM) {
                        VStack(alignment: .leading, spacing: FluxSpacing.sm) {
                            HStack {
                                FluxIcon("creditcard.fill", size: .medium, color: FluxColors.primary)
                                Spacer()
                                FluxText("VISA", style: .headline, color: FluxColors.primary)
                            }
                            Spacer()
                            FluxText("**** **** **** 4242", style: .title3)
                            HStack {
                                VStack(alignment: .leading) {
                                    FluxText("CARDHOLDER", style: .caption)
                                    FluxText("AMAL DOE", style: .footnote)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    FluxText("EXPIRES", style: .caption)
                                    FluxText("12/28", style: .footnote)
                                }
                            }
                        }
                        .frame(height: 180)
                    } back: {
                        VStack(spacing: FluxSpacing.md) {
                            Rectangle()
                                .fill(FluxColors.textPrimary.opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, -FluxSpacing.md)

                            HStack {
                                Spacer()
                                FluxText("CVV", style: .caption)
                                FluxText("123", style: .body)
                                    .padding(.horizontal, FluxSpacing.sm)
                                    .padding(.vertical, FluxSpacing.xxs)
                                    .background(FluxColors.background)
                                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.xs))
                            }
                            Spacer()
                            FluxText("Tap to flip back", style: .footnote)
                        }
                        .frame(height: 180)
                    }
                }

                FluxText("Tap the card to flip", style: .footnote)

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxCardFlap")
        .onAppear {
            cardVM.onFlip = { isFlipped in statusText = "Showing: \(isFlipped ? "Back" : "Front")" }
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxCardFlapViewModel(
                shadow: .medium,
                flipDuration: 0.6,
                onFlip: { isFlipped in print(isFlipped) }
            )

            FluxCardFlap(viewModel: vm) {
                Text("Front content")
            } back: {
                Text("Back content")
            }
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

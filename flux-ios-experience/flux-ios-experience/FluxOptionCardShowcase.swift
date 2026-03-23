import SwiftUI
import flux_ios_foundation

struct FluxOptionCardShowcase: View {
    @StateObject private var singleVM = FluxOptionCardViewModel(
        options: [
            FluxOption(icon: "creditcard.fill", label: "Credit Card", subtitle: "Visa ending in 4242"),
            FluxOption(icon: "building.columns.fill", label: "Bank Transfer", subtitle: "Chase checking"),
            FluxOption(icon: "wallet.pass.fill", label: "Digital Wallet", subtitle: "Apple Pay")
        ],
        selectionMode: .single, selectedIndices: [0]
    )
    @StateObject private var multiVM = FluxOptionCardViewModel(
        options: [
            FluxOption(icon: "bell.fill", label: "Push Notifications"),
            FluxOption(icon: "envelope.fill", label: "Email Alerts"),
            FluxOption(icon: "message.fill", label: "SMS Messages"),
            FluxOption(icon: "phone.fill", label: "Phone Calls")
        ],
        selectionMode: .multi, selectedIndices: [0, 1]
    )

    @State private var selectionText = "Single: {0}"

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                FluxText(selectionText, style: .callout, color: FluxColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))

                section("Single Select") { FluxOptionCard(viewModel: singleVM) }
                section("Multi Select") { FluxOptionCard(viewModel: multiVM) }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxOptionCard")
        .onAppear { setupActions() }
    }

    private func setupActions() {
        singleVM.onSelectionChanged = { indices in selectionText = "Single: \(indices.sorted())" }
        multiVM.onSelectionChanged = { indices in selectionText = "Multi: \(indices.sorted())" }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxOptionCardViewModel(
                options: [
                    FluxOption(icon: "star", label: "Option A"),
                    FluxOption(icon: "heart", label: "Option B")
                ],
                selectionMode: .single,
                selectedIndices: [0],
                onSelectionChanged: { indices in print(indices) }
            )

            FluxOptionCard(viewModel: vm)
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

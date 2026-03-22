import SwiftUI
import FluxComponentsKit

struct FluxExpandableViewShowcase: View {
    @StateObject private var cardVM = FluxExpandableViewModel(title: "Card Style", icon: .system("creditcard.fill"), style: .card)
    @StateObject private var plainVM = FluxExpandableViewModel(title: "Plain Style", icon: .system("doc.text"), style: .plain)
    @StateObject private var borderedVM = FluxExpandableViewModel(title: "Bordered Style", icon: .system("square.dashed"), style: .bordered)

    @State private var toastMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("Card") {
                    FluxExpandableView(viewModel: cardVM) {
                        FluxText("This is the expandable content inside a card-styled container. It can hold any SwiftUI view.", style: .body, color: FluxColors.textSecondary)
                    }
                }
                section("Plain") {
                    FluxExpandableView(viewModel: plainVM) {
                        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
                            FluxText("Item 1", style: .body)
                            FluxText("Item 2", style: .body)
                            FluxText("Item 3", style: .body)
                        }
                    }
                }
                section("Bordered") {
                    FluxExpandableView(viewModel: borderedVM) {
                        FluxText("Bordered expandable content with a subtle border outline.", style: .body, color: FluxColors.textSecondary)
                    }
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxExpandableView")
        .overlay(alignment: .bottom) {
            if let toast = toastMessage {
                FluxText(toast, style: .footnote, color: .white)
                    .padding(.horizontal, FluxSpacing.md)
                    .padding(.vertical, FluxSpacing.sm)
                    .background(FluxColors.secondary.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.bottom, FluxSpacing.xl)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: toastMessage)
        .onAppear { setupActions() }
    }

    private func setupActions() {
        cardVM.onToggle = { expanded in showToast("Card \(expanded ? "expanded" : "collapsed")") }
        plainVM.onToggle = { expanded in showToast("Plain \(expanded ? "expanded" : "collapsed")") }
        borderedVM.onToggle = { expanded in showToast("Bordered \(expanded ? "expanded" : "collapsed")") }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxExpandableViewModel(
                title: "Details",
                icon: "info.circle",
                style: .card,
                onToggle: { expanded in print(expanded) }
            )

            FluxExpandableView(viewModel: vm) {
                Text("Content here")
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

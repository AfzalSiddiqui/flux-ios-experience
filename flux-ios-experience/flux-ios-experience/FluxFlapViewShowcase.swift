import SwiftUI
import flux_ios_foundation

struct FluxFlapViewShowcase: View {
    @StateObject private var underlinedVM = FluxFlapViewModel(
        tabs: [FluxFlapTab(title: "Home", icon: .system("house.fill")), FluxFlapTab(title: "Search", icon: .system("magnifyingglass")), FluxFlapTab(title: "Profile", icon: .system("person.fill"))],
        style: .underlined
    )
    @StateObject private var filledVM = FluxFlapViewModel(
        tabs: [FluxFlapTab(title: "All"), FluxFlapTab(title: "Active"), FluxFlapTab(title: "Archived")],
        style: .filled
    )
    @StateObject private var pillVM = FluxFlapViewModel(
        tabs: [FluxFlapTab(title: "Day"), FluxFlapTab(title: "Week"), FluxFlapTab(title: "Month")],
        style: .pill
    )

    @State private var toastMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("Underlined") {
                    FluxFlapView(viewModel: underlinedVM) { index in
                        FluxText("Content for tab \(index)", style: .body, color: FluxColors.textSecondary)
                            .padding(FluxSpacing.md)
                    }
                }
                section("Filled") {
                    FluxFlapView(viewModel: filledVM) { index in
                        FluxText("Showing \(filledVM.tabs[index].title) items", style: .body, color: FluxColors.textSecondary)
                            .padding(FluxSpacing.md)
                    }
                }
                section("Pill") {
                    FluxFlapView(viewModel: pillVM) { index in
                        FluxText("\(pillVM.tabs[index].title) view content", style: .body, color: FluxColors.textSecondary)
                            .padding(FluxSpacing.md)
                    }
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxFlapView")
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
        underlinedVM.onTabChanged = { index in showToast("Tab: \(underlinedVM.tabs[index].title)") }
        filledVM.onTabChanged = { index in showToast("Tab: \(filledVM.tabs[index].title)") }
        pillVM.onTabChanged = { index in showToast("Tab: \(pillVM.tabs[index].title)") }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { toastMessage = nil }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxFlapViewModel(
                tabs: [
                    FluxFlapTab(title: "Tab 1", icon: "star"),
                    FluxFlapTab(title: "Tab 2")
                ],
                style: .underlined,
                onTabChanged: { index in print(index) }
            )

            FluxFlapView(viewModel: vm) { index in
                Text("Content for \\(index)")
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

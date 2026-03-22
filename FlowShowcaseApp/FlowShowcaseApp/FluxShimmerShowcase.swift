//
//  FluxShimmerShowcase.swift
//  FlowShowcaseApp
//

import SwiftUI
import FluxComponentsKit
import FluxTokensKit

/// Showcase for the FluxShimmer atom and the `.fluxShimmer()` view modifier.
///
/// Demonstrates shimmer applied to atoms, molecules, organisms, standalone
/// placeholder shapes, and the composite skeleton helpers.
struct FluxShimmerShowcase: View {

    /// Controls whether shimmer is active across all demos.
    @State private var isShimmering = true

    // MARK: - Atom ViewModels

    @StateObject private var buttonVM = FluxButtonViewModel(title: "Primary Button", variant: .primary)
    @StateObject private var textVM = FluxTextViewModel(content: "Hello, World!", style: .body)
    @StateObject private var iconVM = FluxIconViewModel(systemName: "star.fill", size: .large)
    @StateObject private var imageVM = FluxImageViewModel(source: .system("photo.fill"))
    @StateObject private var toggleVM = FluxToggleViewModel(isOn: true, label: "Wi-Fi")
    @StateObject private var checkBoxVM = FluxCheckBoxViewModel(isChecked: true, label: "Accept Terms")

    // MARK: - Molecule ViewModels

    @StateObject private var cardVM = FluxCardViewModel()
    @StateObject private var textFieldVM = FluxTextFieldViewModel(label: "Email", placeholder: "Enter email")
    @StateObject private var listRowVM = FluxListRowViewModel(title: "Settings", subtitle: "Manage preferences")

    // MARK: - Organism ViewModels

    @StateObject private var headerVM = FluxHeaderViewModel(title: "Dashboard", subtitle: "Welcome back")

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {

                // Toggle to turn shimmer on/off across all demos
                HStack {
                    FluxText("Shimmer Active", style: .headline)
                    Spacer()
                    Toggle("", isOn: $isShimmering)
                        .labelsHidden()
                }
                .padding(.horizontal, FluxSpacing.md)

                // --- .fluxShimmer() applied to existing components ---

                section("On Atoms") {
                    FluxButton(viewModel: buttonVM)
                        .fluxShimmer(active: isShimmering)

                    FluxText(viewModel: textVM)
                        .fluxShimmer(active: isShimmering)

                    FluxIcon(viewModel: iconVM)
                        .fluxShimmer(active: isShimmering)

                    FluxImage(viewModel: imageVM)
                        .frame(width: 80, height: 80)
                        .fluxShimmer(active: isShimmering)

                    FluxToggle(viewModel: toggleVM)
                        .fluxShimmer(active: isShimmering)

                    FluxCheckBox(viewModel: checkBoxVM)
                        .fluxShimmer(active: isShimmering)
                }

                section("On Molecules") {
                    FluxCard(viewModel: cardVM) {
                        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
                            FluxText("Card Title", style: .headline)
                            FluxText("Card body content goes here.", style: .body)
                        }
                    }
                    .fluxShimmer(active: isShimmering, cornerRadius: FluxRadius.lg)

                    FluxTextField(viewModel: textFieldVM)
                        .fluxShimmer(active: isShimmering)

                    FluxListRow(viewModel: listRowVM)
                        .fluxShimmer(active: isShimmering)
                }

                section("On Organisms") {
                    FluxHeader(viewModel: headerVM)
                        .fluxShimmer(active: isShimmering)
                }

                // --- Standalone FluxShimmer atom ---

                section("Standalone Shapes") {
                    FluxShimmer(shape: .line(width: 200, height: 14))
                    FluxShimmer(shape: .circle(diameter: 48))
                    FluxShimmer(shape: .rectangle(width: .infinity, height: 80, radius: FluxRadius.md))
                }

                section("Text Block") {
                    FluxShimmer.textBlock(lines: 3)
                }

                section("Card Skeleton") {
                    FluxShimmer.card()
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxShimmer")
    }

    // MARK: - Helpers

    /// Wraps content in a titled section matching other showcase screens.
    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: FluxSpacing.sm) {
            FluxText(title, style: .headline)
            content()
        }
    }

    /// Code-example section showing common usage patterns.
    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            // 1. Apply to any component
            FluxButton(viewModel: vm)
                .fluxShimmer(active: isLoading)

            // 2. Custom corner radius
            FluxCard(viewModel: vm) { content }
                .fluxShimmer(active: isLoading, cornerRadius: FluxRadius.lg)

            // 3. Standalone shapes
            FluxShimmer(shape: .line(width: 200, height: 14))
            FluxShimmer(shape: .circle(diameter: 48))

            // 4. Skeleton helpers
            FluxShimmer.textBlock(lines: 3)
            FluxShimmer.card()
            """, style: .code)
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

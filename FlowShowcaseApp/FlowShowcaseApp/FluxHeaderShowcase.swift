import SwiftUI
import FluxComponentsKit

struct FluxHeaderShowcase: View {
    // Organism ViewModels
    @StateObject private var titleOnlyVM = FluxHeaderViewModel(title: "Dashboard")
    @StateObject private var withSubtitleVM = FluxHeaderViewModel(title: "Dashboard", subtitle: "Welcome back, Amal")
    @StateObject private var actionsVM = FluxHeaderViewModel(title: "Dashboard", subtitle: "Welcome back")
    @StateObject private var profileVM = FluxHeaderViewModel(title: "Profile", subtitle: "Edit your details")

    // Atom ViewModels for leading/trailing actions
    @StateObject private var backIconVM = FluxIconViewModel(systemName: "arrow.left", size: .medium, color: FluxColors.primary)
    @StateObject private var bellIconVM = FluxIconViewModel(systemName: "bell.fill", size: .medium, color: FluxColors.primary)
    @StateObject private var menuIconVM = FluxIconViewModel(systemName: "line.3.horizontal", size: .medium, color: FluxColors.primary)
    @StateObject private var settingsIconVM = FluxIconViewModel(systemName: "gear", size: .medium, color: FluxColors.primary)

    // Molecule ViewModel (FluxCard wrapping the header)
    @StateObject private var cardVM = FluxCardViewModel(padding: 0, shadow: .medium)

    // Atom for note
    @StateObject private var dividerVM = FluxDividerViewModel()
    @StateObject private var noteVM = FluxTextViewModel(content: "FluxHeader uses FluxIcon atoms for action buttons and FluxText atoms for title/subtitle.", style: .caption)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                Text("Title Only").font(FluxFont.headline)
                FluxHeader(viewModel: titleOnlyVM)

                FluxDivider(viewModel: dividerVM)

                Text("With Subtitle").font(FluxFont.headline)
                FluxHeader(viewModel: withSubtitleVM)

                FluxDivider(viewModel: FluxDividerViewModel())

                Text("With Actions").font(FluxFont.headline)
                FluxHeader(viewModel: actionsVM) {
                    FluxIcon(viewModel: backIconVM)
                } trailingAction: {
                    FluxIcon(viewModel: bellIconVM)
                }

                FluxDivider(viewModel: FluxDividerViewModel())

                Text("In a Card (Molecule)").font(FluxFont.headline)
                FluxCard(viewModel: cardVM) {
                    FluxHeader(viewModel: profileVM) {
                        FluxIcon(viewModel: menuIconVM)
                    } trailingAction: {
                        FluxIcon(viewModel: settingsIconVM)
                    }
                }

                FluxDivider(viewModel: FluxDividerViewModel())

                // Atom note
                HStack(spacing: FluxSpacing.xs) {
                    FluxIcon(viewModel: FluxIconViewModel(systemName: "atom", size: .small, color: FluxColors.textSecondary))
                    FluxText(viewModel: noteVM)
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxHeader")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
            // 1. Create the Organism ViewModel
            @StateObject var vm = FluxHeaderViewModel(
                title: "Dashboard",
                subtitle: "Welcome back"
            )

            // 2. With Atom actions (FluxIcon)
            @StateObject var backVM =
                FluxIconViewModel(
                    systemName: "arrow.left",
                    color: FluxColors.primary
                )
            @StateObject var bellVM =
                FluxIconViewModel(
                    systemName: "bell.fill",
                    color: FluxColors.primary
                )

            // 3. Compose: Organism + Atoms
            FluxHeader(viewModel: vm) {
                FluxIcon(viewModel: backVM)
            } trailingAction: {
                FluxIcon(viewModel: bellVM)
            }

            // 4. Wrap in a Molecule (FluxCard)
            FluxCard(viewModel: cardVM) {
                FluxHeader(viewModel: vm)
            }
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

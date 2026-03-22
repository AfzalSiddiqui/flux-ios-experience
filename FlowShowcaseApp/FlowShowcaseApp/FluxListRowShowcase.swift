import SwiftUI
import FluxComponentsKit

struct FluxListRowShowcase: View {
    @StateObject private var profileVM = FluxListRowViewModel(icon: "person.fill", title: "Profile", subtitle: "View your profile")
    @StateObject private var settingsVM = FluxListRowViewModel(icon: "gear", title: "Settings", subtitle: "App preferences")
    @StateObject private var notificationsVM = FluxListRowViewModel(icon: "bell.fill", iconColor: FluxColors.warning, title: "Notifications", subtitle: "Manage alerts")
    @StateObject private var versionVM = FluxListRowViewModel(icon: "info.circle", title: "Version 1.0.0", showChevron: false)
    @StateObject private var actionVM = FluxListRowViewModel(icon: "arrow.right.circle.fill", iconColor: FluxColors.success, title: "Tap Me", subtitle: "This row has an action")

    // Atoms for section context
    @StateObject private var dividerVM = FluxDividerViewModel()
    @StateObject private var noteVM = FluxTextViewModel(content: "FluxListRow internally uses FluxIcon atoms for the row icon and chevron.", style: .caption)

    // Action feedback state
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var toastMessage: String?
    @State private var lastTappedRow: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                // Last tapped feedback
                if let lastTapped = lastTappedRow {
                    HStack(spacing: FluxSpacing.xs) {
                        Image(systemName: "hand.tap.fill")
                            .foregroundStyle(FluxColors.primary)
                        Text("Last tapped: \(lastTapped)")
                            .font(FluxFont.callout)
                            .foregroundStyle(FluxColors.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(FluxSpacing.sm)
                    .background(FluxColors.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
                }

                Text("With Icon & Subtitle").font(FluxFont.headline)
                VStack(spacing: 0) {
                    FluxListRow(viewModel: profileVM)
                    FluxDivider(viewModel: FluxDividerViewModel())
                    FluxListRow(viewModel: settingsVM)
                    FluxDivider(viewModel: FluxDividerViewModel())
                    FluxListRow(viewModel: notificationsVM)
                }

                FluxDivider(viewModel: dividerVM)

                Text("Without Chevron").font(FluxFont.headline)
                FluxListRow(viewModel: versionVM)

                FluxDivider(viewModel: FluxDividerViewModel())

                Text("With Action").font(FluxFont.headline)
                FluxListRow(viewModel: actionVM)

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
        .navigationTitle("FluxListRow")
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .overlay(alignment: .bottom) {
            if let toast = toastMessage {
                Text(toast)
                    .font(FluxFont.footnote)
                    .foregroundStyle(.white)
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
        profileVM.action = {
            lastTappedRow = "Profile"
            alertTitle = "Profile"
            alertMessage = "Navigate to profile screen"
            showAlert = true
        }
        settingsVM.action = {
            lastTappedRow = "Settings"
            showToast("Opening Settings...")
        }
        notificationsVM.action = {
            lastTappedRow = "Notifications"
            alertTitle = "Notifications"
            alertMessage = "You have 3 unread notifications"
            showAlert = true
        }
        actionVM.action = {
            lastTappedRow = "Tap Me"
            showToast("Action row tapped!")
        }
    }

    private func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toastMessage = nil
        }
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxListRowViewModel(
                icon: "person.fill",
                iconColor: FluxColors.primary,
                title: "Profile",
                subtitle: "View your profile",
                showChevron: true,
                action: { print("Tapped!") }
            )

            // 2. Pass it to the View
            FluxListRow(viewModel: vm)

            // 3. Row without action (static)
            @StateObject var staticVM = FluxListRowViewModel(
                icon: "info.circle",
                title: "Version 1.0",
                showChevron: false
            )
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

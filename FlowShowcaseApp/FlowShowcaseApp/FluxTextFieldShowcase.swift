import SwiftUI
import FluxComponentsKit

struct FluxTextFieldShowcase: View {
    @StateObject private var emailVM = FluxTextFieldViewModel(label: "Email", placeholder: "Enter your email")
    @StateObject private var passwordVM = FluxTextFieldViewModel(label: "Password", placeholder: "Enter password", isSecure: true)
    @StateObject private var errorVM = FluxTextFieldViewModel(label: "Username", placeholder: "Enter username", text: "bad input", errorMessage: "This username is already taken")

    // Atoms used alongside the molecule
    @StateObject private var sectionTitleVM = FluxTextViewModel(content: "FluxTextField uses atoms internally", style: .caption)
    @StateObject private var dividerVM = FluxDividerViewModel()
    @StateObject private var hintIconVM = FluxIconViewModel(systemName: "info.circle", size: .small, color: FluxColors.textSecondary)
    @StateObject private var hintTextVM = FluxTextViewModel(content: "Text fields combine label, input, and error atoms.", style: .footnote)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                Text("Default").font(FluxFont.headline)
                FluxTextField(viewModel: emailVM)

                FluxDivider(viewModel: dividerVM)

                Text("Secure").font(FluxFont.headline)
                FluxTextField(viewModel: passwordVM)

                FluxDivider(viewModel: FluxDividerViewModel())

                Text("Error State").font(FluxFont.headline)
                FluxTextField(viewModel: errorVM)

                FluxDivider(viewModel: FluxDividerViewModel())

                // Atom usage alongside molecule
                Text("Atoms in Context").font(FluxFont.headline)
                FluxText(viewModel: sectionTitleVM)

                HStack(spacing: FluxSpacing.xs) {
                    FluxIcon(viewModel: hintIconVM)
                    FluxText(viewModel: hintTextVM)
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxTextField")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxTextFieldViewModel(
                label: "Email",
                placeholder: "Enter email"
            )

            // 2. Pass it to the View
            FluxTextField(viewModel: vm)

            // 3. Read the text value
            print(vm.text) // two-way binding

            // 4. Show validation error
            vm.errorMessage = "Invalid email"

            // 5. Secure input (password)
            @StateObject var passVM = FluxTextFieldViewModel(
                label: "Password",
                placeholder: "Enter password",
                isSecure: true
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

import SwiftUI
import FluxComponentsKit

struct FluxFormSectionShowcase: View {
    // Organism ViewModels
    @StateObject private var personalSectionVM = FluxFormSectionViewModel(title: "Personal Information")
    @StateObject private var contactSectionVM = FluxFormSectionViewModel(title: "Contact Details", spacing: FluxSpacing.md)
    @StateObject private var noTitleSectionVM = FluxFormSectionViewModel()

    // Molecule ViewModels (FluxTextField inside the organism)
    @StateObject private var firstNameVM = FluxTextFieldViewModel(label: "First Name", placeholder: "Enter first name")
    @StateObject private var lastNameVM = FluxTextFieldViewModel(label: "Last Name", placeholder: "Enter last name")
    @StateObject private var emailVM = FluxTextFieldViewModel(label: "Email", placeholder: "Enter email")
    @StateObject private var phoneVM = FluxTextFieldViewModel(label: "Phone", placeholder: "+1 (555) 000-0000")
    @StateObject private var bioVM = FluxTextFieldViewModel(label: "Bio", placeholder: "Tell us about yourself")

    // Atom ViewModels
    @StateObject private var dividerVM = FluxDividerViewModel()
    @StateObject private var noteIconVM = FluxIconViewModel(systemName: "lightbulb.fill", size: .small, color: FluxColors.warning)
    @StateObject private var noteTextVM = FluxTextViewModel(content: "FluxFormSection groups FluxTextField molecules with a title and consistent spacing.", style: .caption)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.xl) {
                // Section with title and text field molecules
                FluxFormSection(viewModel: personalSectionVM) {
                    FluxTextField(viewModel: firstNameVM)
                    FluxTextField(viewModel: lastNameVM)
                }

                FluxDivider(viewModel: dividerVM)

                // Section with wider spacing
                FluxFormSection(viewModel: contactSectionVM) {
                    FluxTextField(viewModel: emailVM)
                    FluxTextField(viewModel: phoneVM)
                }

                FluxDivider(viewModel: FluxDividerViewModel())

                // Section without title
                FluxFormSection(viewModel: noTitleSectionVM) {
                    FluxTextField(viewModel: bioVM)
                }

                FluxDivider(viewModel: FluxDividerViewModel())

                // Atom note
                HStack(spacing: FluxSpacing.xs) {
                    FluxIcon(viewModel: noteIconVM)
                    FluxText(viewModel: noteTextVM)
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxFormSection")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
            // 1. Create the Organism ViewModel
            @StateObject var sectionVM =
                FluxFormSectionViewModel(
                    title: "Personal Info",
                    spacing: FluxSpacing.sm
                )

            // 2. Create Molecule ViewModels
            @StateObject var nameVM =
                FluxTextFieldViewModel(
                    label: "Name",
                    placeholder: "Enter name"
                )
            @StateObject var emailVM =
                FluxTextFieldViewModel(
                    label: "Email",
                    placeholder: "Enter email"
                )

            // 3. Compose: Organism + Molecules
            FluxFormSection(viewModel: sectionVM) {
                FluxTextField(viewModel: nameVM)
                FluxTextField(viewModel: emailVM)
            }

            // 4. Read values
            print(nameVM.text)
            print(emailVM.text)
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }
}

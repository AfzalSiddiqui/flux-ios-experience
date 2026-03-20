//
//  ContentView.swift
//  FlowShowcaseApp
//
//  Created by Amal on 20/03/2026.
//

import SwiftUI

// MARK: - App Theme State

final class AppThemeManager: ObservableObject {
    @Published var colorScheme: ColorScheme? = nil
    @Published var activeTheme: ThemeOption = .defaultTheme

    enum ThemeOption: String, CaseIterable {
        case defaultTheme = "Default"
        case darkBrand = "Dark Brand"

        var primary: Color {
            switch self {
            case .defaultTheme: return Color(hex: 0x007AFF)
            case .darkBrand: return Color(hex: 0x6C63FF)
            }
        }

        var accent: Color {
            switch self {
            case .defaultTheme: return Color(hex: 0x5BC0BE)
            case .darkBrand: return Color(hex: 0xF78166)
            }
        }
    }

    func toggleColorScheme() {
        switch colorScheme {
        case .light: colorScheme = .dark
        case .dark: colorScheme = .light
        default: colorScheme = .dark
        }
    }
}

// MARK: - Root View

struct ContentView: View {
    @StateObject private var themeManager = AppThemeManager()

    var body: some View {
        TabView {
            CatalogTab()
                .tabItem {
                    Label("Catalog", systemImage: "square.grid.2x2")
                }

            ExamplesTab()
                .tabItem {
                    Label("Examples", systemImage: "doc.text")
                }

            DosAndDontsTab()
                .tabItem {
                    Label("Guidelines", systemImage: "checkmark.shield")
                }

            ThemeTab()
                .tabItem {
                    Label("Theme", systemImage: "paintbrush")
                }
        }
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.colorScheme)
        .tint(themeManager.activeTheme.primary)
    }
}

// MARK: - Tab 1: Component Catalog

private struct CatalogTab: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Tokens") {
                    NavigationLink("Colors") { TokenColorsView() }
                    NavigationLink("Typography") { TokenTypographyView() }
                    NavigationLink("Spacing") { TokenSpacingView() }
                    NavigationLink("Radius") { TokenRadiusView() }
                    NavigationLink("Shadows") { TokenShadowsView() }
                }
                Section("Atoms") {
                    NavigationLink("FluxButton") { ButtonShowcase() }
                    NavigationLink("FluxText") { TextShowcase() }
                    NavigationLink("FluxIcon") { IconShowcase() }
                    NavigationLink("FluxDivider") { DividerShowcase() }
                    NavigationLink("FluxLoader") { LoaderShowcase() }
                }
                Section("Molecules") {
                    NavigationLink("FluxTextField") { TextFieldShowcase() }
                    NavigationLink("FluxCard") { CardShowcase() }
                    NavigationLink("FluxListRow") { ListRowShowcase() }
                }
                Section("Organisms") {
                    NavigationLink("FluxFormSection") { FormSectionShowcase() }
                    NavigationLink("FluxHeader") { HeaderShowcase() }
                }
            }
            .navigationTitle("Component Catalog")
        }
    }
}

// MARK: - Tab 2: MVVM Examples

private struct ExamplesTab: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Login Flow") { LoginFlowExample() }
                NavigationLink("Dashboard Flow") { DashboardFlowExample() }
                NavigationLink("Payment Flow") { PaymentFlowExample() }
            }
            .navigationTitle("MVVM Examples")
        }
    }
}

// MARK: - Login Flow

private class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    func login() {
        guard isFormValid else {
            errorMessage = "Please fill in all fields"
            return
        }
        errorMessage = nil
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoading = false
            self?.isLoggedIn = true
        }
    }
}

private struct LoginFlowExample: View {
    @StateObject private var vm = LoginViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 4) {
                    Image(systemName: "lock.shield.fill")
                        .resizable().scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color(hex: 0x007AFF))
                    Text("Welcome Back").font(.system(.title2, weight: .bold))
                    Text("Sign in to continue").font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(.top, 32)

                // Form
                VStack(spacing: 16) {
                    fieldView("Email", placeholder: "Enter email", text: $vm.email)
                    fieldView("Password", placeholder: "Enter password", text: $vm.password, isSecure: true)

                    if let error = vm.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(Color(hex: 0xFF3B30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                // Login Button
                Button(action: vm.login) {
                    HStack(spacing: 8) {
                        if vm.isLoading { ProgressView().tint(.white) }
                        Text("Log In").font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background(Color(hex: 0x007AFF))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(vm.isLoading)
                .opacity(vm.isFormValid ? 1.0 : 0.5)

                Button("Forgot Password?") {}
                    .font(.footnote)
                    .foregroundStyle(Color(hex: 0x007AFF))
            }
            .padding(16)
        }
        .navigationTitle("Login")
        .overlay {
            if vm.isLoggedIn {
                successOverlay
            }
        }
    }

    private var successOverlay: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .resizable().scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color(hex: 0x34C759))
            Text("Login Successful!").font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }

    private func fieldView(_ label: String, placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            Group {
                if isSecure {
                    SecureField(placeholder, text: text)
                } else {
                    TextField(placeholder, text: text)
                }
            }
            .font(.body)
            .padding(12)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator), lineWidth: 1))
        }
    }
}

// MARK: - Dashboard Flow

private struct DashboardItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
    let color: UInt
}

private class DashboardViewModel: ObservableObject {
    @Published var greeting = "Welcome back, Amal"
    @Published var balance = "$12,450.00"
    @Published var items: [DashboardItem] = [
        DashboardItem(icon: "arrow.up.right", title: "Send Money", subtitle: "Transfer funds", color: 0x007AFF),
        DashboardItem(icon: "arrow.down.left", title: "Request", subtitle: "Request payment", color: 0x34C759),
        DashboardItem(icon: "creditcard.fill", title: "Cards", subtitle: "Manage cards", color: 0xFF9500),
        DashboardItem(icon: "chart.bar.fill", title: "Analytics", subtitle: "View spending", color: 0x5BC0BE),
    ]
    @Published var transactions: [DashboardItem] = [
        DashboardItem(icon: "bag.fill", title: "Shopping", subtitle: "Today, 2:30 PM", color: 0xFF9500),
        DashboardItem(icon: "cup.and.saucer.fill", title: "Coffee Shop", subtitle: "Today, 9:15 AM", color: 0x8B4513),
        DashboardItem(icon: "fuelpump.fill", title: "Gas Station", subtitle: "Yesterday", color: 0xFF3B30),
    ]
}

private struct DashboardFlowExample: View {
    @StateObject private var vm = DashboardViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Balance Card
                VStack(spacing: 8) {
                    Text(vm.greeting).font(.subheadline).foregroundStyle(.secondary)
                    Text(vm.balance).font(.system(.largeTitle, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(Color(hex: 0x007AFF))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                // Quick Actions
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(vm.items) { item in
                        quickAction(item)
                    }
                }

                // Recent Transactions
                Text("Recent Transactions").font(.headline)
                VStack(spacing: 0) {
                    ForEach(Array(vm.transactions.enumerated()), id: \.element.id) { index, txn in
                        transactionRow(txn)
                        if index < vm.transactions.count - 1 {
                            Rectangle().fill(Color(.separator)).frame(height: 1).padding(.leading, 52)
                        }
                    }
                }
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(16)
        }
        .navigationTitle("Dashboard")
    }

    private func quickAction(_ item: DashboardItem) -> some View {
        VStack(spacing: 8) {
            Image(systemName: item.icon)
                .resizable().scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color(hex: item.color))
            Text(item.title).font(.caption).fontWeight(.medium)
            Text(item.subtitle).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func transactionRow(_ item: DashboardItem) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.icon)
                .resizable().scaledToFit()
                .frame(width: 20, height: 20)
                .padding(8)
                .foregroundStyle(Color(hex: item.color))
                .background(Color(hex: item.color).opacity(0.12))
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title).font(.body)
                Text(item.subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text("-$4.50").font(.body).fontWeight(.medium)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Payment Flow

private class PaymentViewModel: ObservableObject {
    @Published var amount = ""
    @Published var note = ""
    @Published var isProcessing = false
    @Published var isComplete = false
    @Published var selectedRecipient = 0

    let recipients = ["Amal", "Sara", "Omar", "Layla"]

    func processPayment() {
        guard !amount.isEmpty else { return }
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.isProcessing = false
            self?.isComplete = true
        }
    }
}

private struct PaymentFlowExample: View {
    @StateObject private var vm = PaymentViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Recipient Picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Send to").font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(vm.recipients.enumerated()), id: \.offset) { index, name in
                                recipientChip(name, isSelected: index == vm.selectedRecipient)
                                    .onTapGesture { vm.selectedRecipient = index }
                            }
                        }
                    }
                }

                // Amount
                VStack(spacing: 8) {
                    Text("Amount").font(.caption).foregroundStyle(.secondary)
                    HStack {
                        Text("$").font(.system(.largeTitle, weight: .bold))
                        TextField("0.00", text: $vm.amount)
                            .font(.system(.largeTitle, weight: .bold))
                            .keyboardType(.decimalPad)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                // Note
                VStack(alignment: .leading, spacing: 8) {
                    Text("Note").font(.caption).foregroundStyle(.secondary)
                    TextField("Add a note (optional)", text: $vm.note)
                        .font(.body)
                        .padding(12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator), lineWidth: 1))
                }

                // Pay Button
                Button(action: vm.processPayment) {
                    HStack(spacing: 8) {
                        if vm.isProcessing { ProgressView().tint(.white) }
                        Text(vm.isProcessing ? "Processing..." : "Pay Now")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundStyle(.white)
                    .background(vm.amount.isEmpty ? Color.gray : Color(hex: 0x007AFF))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(vm.amount.isEmpty || vm.isProcessing)
            }
            .padding(16)
        }
        .navigationTitle("Send Payment")
        .overlay {
            if vm.isComplete {
                VStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable().scaledToFit()
                        .frame(width: 64, height: 64)
                        .foregroundStyle(Color(hex: 0x34C759))
                    Text("Payment Sent!").font(.title2).fontWeight(.bold)
                    Text("$\(vm.amount) to \(vm.recipients[vm.selectedRecipient])")
                        .font(.body).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
            }
        }
    }

    private func recipientChip(_ name: String, isSelected: Bool) -> some View {
        VStack(spacing: 6) {
            Circle()
                .fill(isSelected ? Color(hex: 0x007AFF) : Color(.secondarySystemBackground))
                .frame(width: 48, height: 48)
                .overlay(
                    Text(String(name.prefix(1)))
                        .font(.headline)
                        .foregroundStyle(isSelected ? .white : .primary)
                )
            Text(name).font(.caption)
                .foregroundStyle(isSelected ? Color(hex: 0x007AFF) : .primary)
        }
    }
}

// MARK: - Tab 3: Do's and Don'ts

private struct DosAndDontsTab: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    guidelineSection(
                        title: "Colors",
                        dos: [
                            "Use FluxColors.primary for main actions",
                            "Use FluxColors.error for destructive actions",
                            "Use FluxColors.textSecondary for helper text",
                        ],
                        donts: [
                            "Don't hard-code hex values like Color(#FF0000)",
                            "Don't use .red or .blue — use semantic tokens",
                            "Don't mix UIColor with SwiftUI Color directly",
                        ]
                    )

                    guidelineSection(
                        title: "Typography",
                        dos: [
                            "Use FluxFont tokens for all text styles",
                            "Use .body for content, .headline for emphasis",
                            "Support Dynamic Type by using system fonts",
                        ],
                        donts: [
                            "Don't use custom font sizes like .system(size: 14)",
                            "Don't mix font weights inconsistently",
                            "Don't disable Dynamic Type scaling",
                        ]
                    )

                    guidelineSection(
                        title: "Spacing",
                        dos: [
                            "Use FluxSpacing tokens for all padding/margins",
                            "Use .md (16pt) as the default content padding",
                            "Maintain consistent spacing within sections",
                        ],
                        donts: [
                            "Don't use magic numbers like .padding(13)",
                            "Don't mix spacing values arbitrarily",
                            "Don't use zero spacing between related elements",
                        ]
                    )

                    guidelineSection(
                        title: "Components",
                        dos: [
                            "Use FluxButton for all tappable actions",
                            "Use FluxCard for elevated content containers",
                            "Use FluxTextField for all user input",
                        ],
                        donts: [
                            "Don't build custom buttons with raw Text + onTap",
                            "Don't create one-off card styles per screen",
                            "Don't bypass component APIs with inline styles",
                        ]
                    )

                    guidelineSection(
                        title: "Accessibility",
                        dos: [
                            "Provide accessibilityLabel for all interactive elements",
                            "Test with VoiceOver enabled",
                            "Ensure minimum 4.5:1 contrast ratio for text",
                        ],
                        donts: [
                            "Don't hide important content from accessibility",
                            "Don't use color alone to convey information",
                            "Don't set fixed font sizes that ignore Dynamic Type",
                        ]
                    )
                }
                .padding(16)
            }
            .navigationTitle("Do's & Don'ts")
        }
    }

    private func guidelineSection(title: String, dos: [String], donts: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.system(.title3, weight: .bold))

            VStack(alignment: .leading, spacing: 6) {
                ForEach(dos, id: \.self) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color(hex: 0x34C759))
                            .font(.body)
                        Text(item).font(.body)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                ForEach(donts, id: \.self) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color(hex: 0xFF3B30))
                            .font(.body)
                        Text(item).font(.body)
                    }
                }
            }
        }
    }
}

// MARK: - Tab 4: Theme Switcher

private struct ThemeTab: View {
    @EnvironmentObject var themeManager: AppThemeManager

    var body: some View {
        NavigationStack {
            List {
                Section("Color Scheme") {
                    Button("System Default") { themeManager.colorScheme = nil }
                        .foregroundStyle(themeManager.colorScheme == nil ? Color(hex: 0x007AFF) : .primary)
                    Button("Light Mode") { themeManager.colorScheme = .light }
                        .foregroundStyle(themeManager.colorScheme == .light ? Color(hex: 0x007AFF) : .primary)
                    Button("Dark Mode") { themeManager.colorScheme = .dark }
                        .foregroundStyle(themeManager.colorScheme == .dark ? Color(hex: 0x007AFF) : .primary)
                }

                Section("Brand Theme") {
                    ForEach(AppThemeManager.ThemeOption.allCases, id: \.rawValue) { theme in
                        Button {
                            themeManager.activeTheme = theme
                        } label: {
                            HStack {
                                Circle().fill(theme.primary).frame(width: 24, height: 24)
                                Circle().fill(theme.accent).frame(width: 24, height: 24)
                                Text(theme.rawValue)
                                Spacer()
                                if themeManager.activeTheme == theme {
                                    Image(systemName: "checkmark").foregroundStyle(Color(hex: 0x007AFF))
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }

                Section("Preview") {
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(themeManager.activeTheme.primary)
                                .frame(height: 48)
                                .overlay(Text("Primary").font(.caption).foregroundStyle(.white))
                            RoundedRectangle(cornerRadius: 8)
                                .fill(themeManager.activeTheme.accent)
                                .frame(height: 48)
                                .overlay(Text("Accent").font(.caption).foregroundStyle(.white))
                        }

                        // Sample button
                        Text("Sample Button")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundStyle(.white)
                            .background(themeManager.activeTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Theme Settings")
        }
    }
}

// MARK: - Token Showcases

private struct TokenColorsView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                ColorSwatch(name: "Primary", color: Color(hex: 0x007AFF))
                ColorSwatch(name: "Secondary", color: Color(hex: 0x1C2541))
                ColorSwatch(name: "Accent", color: Color(hex: 0x5BC0BE))
                ColorSwatch(name: "Success", color: Color(hex: 0x34C759))
                ColorSwatch(name: "Warning", color: Color(hex: 0xFF9500))
                ColorSwatch(name: "Error", color: Color(hex: 0xFF3B30))
                ColorSwatch(name: "Background", color: Color(.systemBackground))
                ColorSwatch(name: "Surface", color: Color(.secondarySystemBackground))
                ColorSwatch(name: "Text", color: Color(.label))
            }
            .padding(16)
        }
        .navigationTitle("Colors")
    }
}

private struct TokenTypographyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Large Title").font(.system(.largeTitle, weight: .bold))
                Text("Title").font(.system(.title, weight: .bold))
                Text("Title 2").font(.system(.title2, weight: .semibold))
                Text("Title 3").font(.system(.title3, weight: .semibold))
                Text("Headline").font(.system(.headline, weight: .semibold))
                Text("Body").font(.system(.body, weight: .regular))
                Text("Callout").font(.system(.callout, weight: .regular))
                Text("Footnote").font(.system(.footnote, weight: .regular))
                Text("Caption").font(.system(.caption, weight: .regular))
            }
            .padding(16)
        }
        .navigationTitle("Typography")
    }
}

private struct TokenSpacingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                SpacingRow(label: "xxxs", value: 2)
                SpacingRow(label: "xxs", value: 4)
                SpacingRow(label: "xs", value: 8)
                SpacingRow(label: "sm", value: 12)
                SpacingRow(label: "md", value: 16)
                SpacingRow(label: "lg", value: 24)
                SpacingRow(label: "xl", value: 32)
                SpacingRow(label: "xxl", value: 48)
            }
            .padding(16)
        }
        .navigationTitle("Spacing")
    }
}

private struct TokenRadiusView: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                RadiusDemo(label: "xs", radius: 4)
                RadiusDemo(label: "sm", radius: 8)
                RadiusDemo(label: "md", radius: 12)
                RadiusDemo(label: "lg", radius: 16)
                RadiusDemo(label: "xl", radius: 24)
            }
            .padding(16)
        }
        .navigationTitle("Corner Radius")
    }
}

private struct TokenShadowsView: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 24) {
                ShadowDemo(label: "Small", radius: 4, y: 2)
                ShadowDemo(label: "Medium", radius: 8, y: 4)
                ShadowDemo(label: "Large", radius: 16, y: 8)
            }
            .padding(16)
        }
        .navigationTitle("Shadows")
    }
}

// MARK: - Atom Showcases

private struct ButtonShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SectionHeader("Variants")
                demoButton("Primary", bg: 0x007AFF)
                outlinedButton("Secondary", color: 0x007AFF)
                demoButton("Destructive", bg: 0xFF3B30)

                SectionHeader("Sizes")
                sizedButton("Small", vPad: 8, hPad: 12, font: .footnote, radius: 8)
                sizedButton("Medium", vPad: 12, hPad: 16, font: .body, radius: 12)
                sizedButton("Large", vPad: 16, hPad: 24, font: .headline, radius: 16)

                SectionHeader("States")
                HStack(spacing: 8) {
                    ProgressView().tint(.white)
                    Text("Loading").font(.body)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12).padding(.horizontal, 16)
                .foregroundStyle(.white)
                .background(Color(hex: 0x007AFF))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                demoButton("Disabled", bg: 0x007AFF).opacity(0.5)
            }
            .padding(16)
        }
        .navigationTitle("FluxButton")
    }

    private func demoButton(_ title: String, bg: UInt) -> some View {
        Text(title).font(.body)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12).padding(.horizontal, 16)
            .foregroundStyle(.white)
            .background(Color(hex: bg))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func outlinedButton(_ title: String, color: UInt) -> some View {
        Text(title).font(.body)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12).padding(.horizontal, 16)
            .foregroundStyle(Color(hex: color))
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: color), lineWidth: 1.5))
    }

    private func sizedButton(_ title: String, vPad: CGFloat, hPad: CGFloat, font: Font.TextStyle, radius: CGFloat) -> some View {
        Text(title).font(.system(font))
            .frame(maxWidth: .infinity)
            .padding(.vertical, vPad).padding(.horizontal, hPad)
            .foregroundStyle(.white)
            .background(Color(hex: 0x007AFF))
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

private struct TextShowcase: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Large Title").font(.system(.largeTitle, weight: .bold))
                Text("Title").font(.system(.title, weight: .bold))
                Text("Headline").font(.system(.headline, weight: .semibold))
                Text("Body text for content").font(.body)
                Text("Caption text").font(.caption).foregroundStyle(.secondary)
                Text("Custom color").font(.body).foregroundStyle(Color(hex: 0x5BC0BE))
            }
            .padding(16)
        }
        .navigationTitle("FluxText")
    }
}

private struct IconShowcase: View {
    let icons = ["star.fill", "heart.fill", "bell.fill", "gear", "person.fill", "house.fill"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader("Sizes")
                HStack(spacing: 24) {
                    iconView("star.fill", size: 16, label: "Small")
                    iconView("star.fill", size: 24, label: "Medium")
                    iconView("star.fill", size: 32, label: "Large")
                }
                SectionHeader("Gallery")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
                    ForEach(icons, id: \.self) { name in
                        VStack(spacing: 4) {
                            Image(systemName: name).resizable().scaledToFit()
                                .frame(width: 24, height: 24).foregroundStyle(Color(hex: 0x007AFF))
                            Text(name).font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxIcon")
    }

    private func iconView(_ name: String, size: CGFloat, label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: name).resizable().scaledToFit()
                .frame(width: size, height: size).foregroundStyle(Color(hex: 0x007AFF))
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct DividerShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Horizontal")
                Rectangle().fill(Color(.opaqueSeparator)).frame(height: 1)
                SectionHeader("Custom Color")
                Rectangle().fill(Color(hex: 0x007AFF)).frame(height: 1)
                SectionHeader("Vertical")
                HStack(spacing: 16) {
                    Text("Left")
                    Rectangle().fill(Color(.opaqueSeparator)).frame(width: 1, height: 40)
                    Text("Right")
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxDivider")
    }
}

private struct LoaderShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                SectionHeader("Sizes")
                HStack(spacing: 40) {
                    VStack(spacing: 8) { ProgressView().controlSize(.small).tint(Color(hex: 0x007AFF)); Text("Small").font(.caption).foregroundStyle(.secondary) }
                    VStack(spacing: 8) { ProgressView().controlSize(.regular).tint(Color(hex: 0x007AFF)); Text("Medium").font(.caption).foregroundStyle(.secondary) }
                    VStack(spacing: 8) { ProgressView().controlSize(.regular).scaleEffect(1.5).tint(Color(hex: 0x007AFF)); Text("Large").font(.caption).foregroundStyle(.secondary) }
                }
                SectionHeader("Colors")
                HStack(spacing: 40) {
                    ProgressView().tint(Color(hex: 0x007AFF))
                    ProgressView().tint(Color(hex: 0x34C759))
                    ProgressView().tint(Color(hex: 0xFF3B30))
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxLoader")
    }
}

// MARK: - Molecule Showcases

private struct TextFieldShowcase: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorField = "bad input"

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Default")
                demoField("Email", placeholder: "Enter email", text: $email)
                SectionHeader("Secure")
                demoField("Password", placeholder: "Enter password", text: $password, isSecure: true)
                SectionHeader("Error State")
                demoField("Username", placeholder: "", text: $errorField, error: "This field is required")
            }
            .padding(16)
        }
        .navigationTitle("FluxTextField")
    }

    private func demoField(_ label: String, placeholder: String, text: Binding<String>, isSecure: Bool = false, error: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            Group {
                if isSecure { SecureField(placeholder, text: text) }
                else { TextField(placeholder, text: text) }
            }
            .font(.body).padding(12)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(error != nil ? Color(hex: 0xFF3B30) : Color(.separator), lineWidth: 1.5))
            if let error { Text(error).font(.caption).foregroundStyle(Color(hex: 0xFF3B30)) }
        }
    }
}

private struct CardShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Default")
                cardDemo(shadow: 4, y: 2) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title").font(.headline)
                        Text("Default padding, corner radius, and shadow.").font(.body).foregroundStyle(.secondary)
                    }
                }
                SectionHeader("Medium Shadow")
                cardDemo(shadow: 8, y: 4) {
                    HStack(spacing: 12) {
                        Image(systemName: "creditcard.fill").resizable().scaledToFit()
                            .frame(width: 32, height: 32).foregroundStyle(Color(hex: 0x007AFF))
                        VStack(alignment: .leading) {
                            Text("Payment Card").font(.headline)
                            Text("**** 4242").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxCard")
    }

    private func cardDemo<C: View>(shadow: CGFloat, y: CGFloat, @ViewBuilder content: () -> C) -> some View {
        content().padding(16)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.12), radius: shadow, x: 0, y: y)
    }
}

private struct ListRowShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SectionHeader("With Icon & Subtitle")
                rowDemo(icon: "person.fill", title: "Profile", subtitle: "View your profile")
                rowDivider()
                rowDemo(icon: "gear", title: "Settings", subtitle: "App preferences")
                rowDivider()
                SectionHeader("Without Chevron")
                rowDemo(icon: "info.circle", title: "Version 1.0.0", subtitle: nil, chevron: false)
            }
            .padding(16)
        }
        .navigationTitle("FluxListRow")
    }

    private func rowDemo(icon: String, title: String, subtitle: String?, chevron: Bool = true) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon).resizable().scaledToFit()
                .frame(width: 24, height: 24).foregroundStyle(Color(hex: 0x007AFF))
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.body)
                if let subtitle { Text(subtitle).font(.caption).foregroundStyle(.secondary) }
            }
            Spacer()
            if chevron {
                Image(systemName: "chevron.right").resizable().scaledToFit()
                    .frame(width: 12, height: 12).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 12)
    }

    private func rowDivider() -> some View {
        Rectangle().fill(Color(.separator)).frame(height: 1)
    }
}

// MARK: - Organism Showcases

private struct FormSectionShowcase: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Personal Information").font(.headline).padding(.bottom, 8)
                formField("Full Name", text: $name)
                formField("Email", text: $email)
            }
            .padding(16)
        }
        .navigationTitle("FluxFormSection")
    }

    private func formField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            TextField("Enter \(label.lowercased())", text: text)
                .font(.body).padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator), lineWidth: 1))
        }
    }
}

private struct HeaderShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Title Only")
                headerDemo(title: "Dashboard", subtitle: nil, leading: false, trailing: false)
                SectionHeader("With Subtitle")
                headerDemo(title: "Dashboard", subtitle: "Welcome back, Amal", leading: false, trailing: false)
                SectionHeader("With Actions")
                headerDemo(title: "Dashboard", subtitle: "Welcome back", leading: true, trailing: true)
            }
            .padding(16)
        }
        .navigationTitle("FluxHeader")
    }

    private func headerDemo(title: String, subtitle: String?, leading: Bool, trailing: Bool) -> some View {
        HStack {
            if leading { Image(systemName: "arrow.left").foregroundStyle(Color(hex: 0x007AFF)) }
            VStack(spacing: 2) {
                Text(title).font(.system(.title2, weight: .semibold))
                if let subtitle { Text(subtitle).font(.subheadline).foregroundStyle(.secondary) }
            }
            .frame(maxWidth: .infinity)
            if trailing { Image(systemName: "bell.fill").foregroundStyle(Color(hex: 0x007AFF)) }
        }
        .padding(.horizontal, 16).padding(.vertical, 12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Shared Helpers

private struct SectionHeader: View {
    let title: String
    init(_ title: String) { self.title = title }
    var body: some View {
        Text(title)
            .font(.system(.headline, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 8)
    }
}

private struct ColorSwatch: View {
    let name: String
    let color: Color
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8).fill(color).frame(height: 48)
            Text(name).font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct SpacingRow: View {
    let label: String
    let value: CGFloat
    var body: some View {
        HStack {
            Text(label).font(.system(.footnote, design: .monospaced)).frame(width: 40, alignment: .leading)
            RoundedRectangle(cornerRadius: 2).fill(Color(hex: 0x007AFF)).frame(width: value * 4, height: 16)
            Text("\(Int(value))pt").font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct RadiusDemo: View {
    let label: String
    let radius: CGFloat
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color(hex: 0x007AFF).opacity(0.15))
                .overlay(RoundedRectangle(cornerRadius: radius).stroke(Color(hex: 0x007AFF), lineWidth: 1.5))
                .frame(width: 48, height: 48)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct ShadowDemo: View {
    let label: String
    let radius: CGFloat
    let y: CGFloat
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
                .frame(width: 64, height: 64)
                .shadow(color: .black.opacity(0.12), radius: radius, x: 0, y: y)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Hex Color

private extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

#Preview {
    ContentView()
}

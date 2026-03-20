//
//  ContentView.swift
//  FlowShowcaseApp
//
//  Created by Amal on 20/03/2026.
//

import SwiftUI

struct ContentView: View {
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
            .navigationTitle("Flux Design System")
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
                button("Primary", hex: 0x007AFF, style: .filled)
                button("Secondary", hex: 0x007AFF, style: .outlined)
                button("Destructive", hex: 0xFF3B30, style: .filled)

                SectionHeader("Sizes")
                sizedButton("Small", vPad: 8, hPad: 12, font: .footnote, radius: 8)
                sizedButton("Medium", vPad: 12, hPad: 16, font: .body, radius: 12)
                sizedButton("Large", vPad: 16, hPad: 24, font: .headline, radius: 16)

                SectionHeader("States")
                loadingButton()
                disabledButton()
            }
            .padding(16)
        }
        .navigationTitle("FluxButton")
    }

    private func button(_ title: String, hex: UInt, style: ButtonDemoStyle) -> some View {
        Text(title)
            .font(.body)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .foregroundStyle(style == .outlined ? Color(hex: hex) : .white)
            .background(style == .outlined ? Color.clear : Color(hex: hex))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style == .outlined ? Color(hex: hex) : .clear, lineWidth: 1.5)
            )
    }

    private func sizedButton(_ title: String, vPad: CGFloat, hPad: CGFloat, font: Font.TextStyle, radius: CGFloat) -> some View {
        Text(title)
            .font(.system(font))
            .frame(maxWidth: .infinity)
            .padding(.vertical, vPad)
            .padding(.horizontal, hPad)
            .foregroundStyle(.white)
            .background(Color(hex: 0x007AFF))
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }

    private func loadingButton() -> some View {
        HStack(spacing: 8) {
            ProgressView().tint(.white)
            Text("Loading")
                .font(.body)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .foregroundStyle(.white)
        .background(Color(hex: 0x007AFF))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func disabledButton() -> some View {
        Text("Disabled")
            .font(.body)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .foregroundStyle(.white)
            .background(Color(hex: 0x007AFF))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .opacity(0.5)
    }

    private enum ButtonDemoStyle { case filled, outlined }
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
                    iconDemo("star.fill", size: 16, label: "Small")
                    iconDemo("star.fill", size: 24, label: "Medium")
                    iconDemo("star.fill", size: 32, label: "Large")
                }

                SectionHeader("Colors")
                HStack(spacing: 24) {
                    iconDemo("heart.fill", size: 24, label: "Primary", color: 0x007AFF)
                    iconDemo("heart.fill", size: 24, label: "Error", color: 0xFF3B30)
                    iconDemo("heart.fill", size: 24, label: "Accent", color: 0x5BC0BE)
                }

                SectionHeader("Gallery")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
                    ForEach(icons, id: \.self) { name in
                        VStack(spacing: 4) {
                            Image(systemName: name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color(hex: 0x007AFF))
                            Text(name).font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxIcon")
    }

    private func iconDemo(_ name: String, size: CGFloat, label: String, color: UInt = 0x007AFF) -> some View {
        VStack(spacing: 4) {
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(Color(hex: color))
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

                SectionHeader("Vertical (in HStack)")
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
                    VStack(spacing: 8) {
                        ProgressView().controlSize(.small).tint(Color(hex: 0x007AFF))
                        Text("Small").font(.caption).foregroundStyle(.secondary)
                    }
                    VStack(spacing: 8) {
                        ProgressView().controlSize(.regular).tint(Color(hex: 0x007AFF))
                        Text("Medium").font(.caption).foregroundStyle(.secondary)
                    }
                    VStack(spacing: 8) {
                        ProgressView().controlSize(.regular).scaleEffect(1.5).tint(Color(hex: 0x007AFF))
                        Text("Large").font(.caption).foregroundStyle(.secondary)
                    }
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
                labeledField("Email", placeholder: "Enter email", text: $email)

                SectionHeader("Secure")
                labeledField("Password", placeholder: "Enter password", text: $password, isSecure: true)

                SectionHeader("Error State")
                labeledField("Username", placeholder: "", text: $errorField, error: "This field is required")
            }
            .padding(16)
        }
        .navigationTitle("FluxTextField")
    }

    private func labeledField(_ label: String, placeholder: String, text: Binding<String>, isSecure: Bool = false, error: String? = nil) -> some View {
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
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(error != nil ? Color(hex: 0xFF3B30) : Color(.separator), lineWidth: 1.5)
            )
            if let error {
                Text(error).font(.caption).foregroundStyle(Color(hex: 0xFF3B30))
            }
        }
    }
}

private struct CardShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Default Card")
                cardView(shadow: 4, shadowY: 2) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title").font(.headline)
                        Text("This is a card with default padding, corner radius, and shadow.")
                            .font(.body).foregroundStyle(.secondary)
                    }
                }

                SectionHeader("Medium Shadow")
                cardView(shadow: 8, shadowY: 4) {
                    HStack(spacing: 12) {
                        Image(systemName: "creditcard.fill")
                            .resizable().scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color(hex: 0x007AFF))
                        VStack(alignment: .leading) {
                            Text("Payment Card").font(.headline)
                            Text("**** 4242").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }

                SectionHeader("Large Shadow")
                cardView(shadow: 16, shadowY: 8) {
                    Text("Elevated card with large shadow")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(16)
        }
        .navigationTitle("FluxCard")
    }

    private func cardView<Content: View>(shadow: CGFloat, shadowY: CGFloat, @ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(16)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.12), radius: shadow, x: 0, y: shadowY)
    }
}

private struct ListRowShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SectionHeader("With Icon & Subtitle")
                rowView(icon: "person.fill", title: "Profile", subtitle: "View your profile")
                rowDivider()
                rowView(icon: "gear", title: "Settings", subtitle: "App preferences")
                rowDivider()

                SectionHeader("Without Subtitle")
                rowView(icon: "bell.fill", title: "Notifications", subtitle: nil)
                rowDivider()

                SectionHeader("Without Chevron")
                rowView(icon: "info.circle", title: "Version 1.0.0", subtitle: nil, chevron: false)
            }
            .padding(16)
        }
        .navigationTitle("FluxListRow")
    }

    private func rowView(icon: String, title: String, subtitle: String?, chevron: Bool = true) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .resizable().scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color(hex: 0x007AFF))
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.body)
                if let subtitle {
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            if chevron {
                Image(systemName: "chevron.right")
                    .resizable().scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.secondary)
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
    @State private var phone = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Personal Info section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Personal Information")
                        .font(.headline)
                        .padding(.bottom, 8)
                    fieldView("Full Name", text: $name)
                    fieldView("Email", text: $email)
                    fieldView("Phone", text: $phone)
                }

                // Wrapped in card
                VStack(alignment: .leading, spacing: 8) {
                    Text("In a Card")
                        .font(.headline)
                        .padding(.bottom, 8)
                    fieldView("Field 1", text: .constant(""))
                    fieldView("Field 2", text: .constant(""))
                }
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
            }
            .padding(16)
        }
        .navigationTitle("FluxFormSection")
    }

    private func fieldView(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            TextField("Enter \(label.lowercased())", text: text)
                .font(.body)
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.separator), lineWidth: 1.5)
                )
        }
    }
}

private struct HeaderShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader("Title Only")
                headerView(title: "Dashboard", subtitle: nil, leading: false, trailing: false)

                SectionHeader("With Subtitle")
                headerView(title: "Dashboard", subtitle: "Welcome back, Amal", leading: false, trailing: false)

                SectionHeader("With Actions")
                headerView(title: "Dashboard", subtitle: "Welcome back", leading: true, trailing: true)
            }
            .padding(16)
        }
        .navigationTitle("FluxHeader")
    }

    private func headerView(title: String, subtitle: String?, leading: Bool, trailing: Bool) -> some View {
        HStack {
            if leading {
                Image(systemName: "arrow.left")
                    .foregroundStyle(Color(hex: 0x007AFF))
            }
            VStack(spacing: 2) {
                Text(title).font(.system(.title2, weight: .semibold))
                if let subtitle {
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            if trailing {
                Image(systemName: "bell.fill")
                    .foregroundStyle(Color(hex: 0x007AFF))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
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
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: 48)
            Text(name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct SpacingRow: View {
    let label: String
    let value: CGFloat

    var body: some View {
        HStack {
            Text(label)
                .font(.system(.footnote, design: .monospaced))
                .frame(width: 40, alignment: .leading)
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(hex: 0x007AFF))
                .frame(width: value * 4, height: 16)
            Text("\(Int(value))pt")
                .font(.caption)
                .foregroundStyle(.secondary)
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
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(hex: 0x007AFF), lineWidth: 1.5)
                )
                .frame(width: 48, height: 48)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
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
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
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

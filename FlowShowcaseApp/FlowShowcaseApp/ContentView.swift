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
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    colorSection
                    typographySection
                    spacingSection
                    radiusSection
                    shadowSection
                }
                .padding(16)
            }
            .navigationTitle("Flux Tokens")
            .background(Color(.systemBackground))
        }
    }

    // MARK: - Colors

    private var colorSection: some View {
        TokenSection(title: "Colors") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                ColorSwatch(name: "Primary", color: Color(hex: 0x007AFF))
                ColorSwatch(name: "Secondary", color: Color(hex: 0x1C2541))
                ColorSwatch(name: "Accent", color: Color(hex: 0x5BC0BE))
                ColorSwatch(name: "Success", color: Color(hex: 0x34C759))
                ColorSwatch(name: "Warning", color: Color(hex: 0xFF9500))
                ColorSwatch(name: "Error", color: Color(hex: 0xFF3B30))
            }
        }
    }

    // MARK: - Typography

    private var typographySection: some View {
        TokenSection(title: "Typography") {
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
        }
    }

    // MARK: - Spacing

    private var spacingSection: some View {
        TokenSection(title: "Spacing") {
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
        }
    }

    // MARK: - Radius

    private var radiusSection: some View {
        TokenSection(title: "Corner Radius") {
            HStack(spacing: 16) {
                RadiusDemo(label: "xs", radius: 4)
                RadiusDemo(label: "sm", radius: 8)
                RadiusDemo(label: "md", radius: 12)
                RadiusDemo(label: "lg", radius: 16)
                RadiusDemo(label: "xl", radius: 24)
            }
        }
    }

    // MARK: - Shadows

    private var shadowSection: some View {
        TokenSection(title: "Shadows") {
            HStack(spacing: 24) {
                ShadowDemo(label: "Small", radius: 4, y: 2)
                ShadowDemo(label: "Medium", radius: 8, y: 4)
                ShadowDemo(label: "Large", radius: 16, y: 8)
            }
        }
    }
}

// MARK: - Supporting Views

private struct TokenSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(.title2, weight: .bold))
            content
        }
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

import SwiftUI
import FluxComponentsKit

struct FluxIconShowcase: View {
    @StateObject private var smallVM = FluxIconViewModel(systemName: "star.fill", size: .small, color: FluxColors.primary)
    @StateObject private var mediumVM = FluxIconViewModel(systemName: "star.fill", size: .medium, color: FluxColors.primary)
    @StateObject private var largeVM = FluxIconViewModel(systemName: "star.fill", size: .large, color: FluxColors.primary)

    @StateObject private var heartVM = FluxIconViewModel(systemName: "heart.fill", color: FluxColors.error)
    @StateObject private var bellVM = FluxIconViewModel(systemName: "bell.fill", color: FluxColors.warning)
    @StateObject private var gearVM = FluxIconViewModel(systemName: "gear", color: FluxColors.textSecondary)
    @StateObject private var personVM = FluxIconViewModel(systemName: "person.fill", color: FluxColors.primary)
    @StateObject private var houseVM = FluxIconViewModel(systemName: "house.fill", color: FluxColors.success)
    @StateObject private var checkVM = FluxIconViewModel(systemName: "checkmark.circle.fill", color: FluxColors.accent)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FluxSpacing.lg) {
                Text("Sizes").font(FluxFont.headline)
                HStack(spacing: FluxSpacing.xl) {
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: smallVM)
                        Text("Small").font(FluxFont.caption)
                    }
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: mediumVM)
                        Text("Medium").font(FluxFont.caption)
                    }
                    VStack(spacing: FluxSpacing.xs) {
                        FluxIcon(viewModel: largeVM)
                        Text("Large").font(FluxFont.caption)
                    }
                }

                Text("Gallery").font(FluxFont.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 72))], spacing: FluxSpacing.md) {
                    iconTile(heartVM, label: "heart.fill")
                    iconTile(bellVM, label: "bell.fill")
                    iconTile(gearVM, label: "gear")
                    iconTile(personVM, label: "person.fill")
                    iconTile(houseVM, label: "house.fill")
                    iconTile(checkVM, label: "checkmark")
                }

                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxIcon")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            Text("How to Use").font(FluxFont.headline)
            Text("""
            // 1. Create the ViewModel
            @StateObject var vm = FluxIconViewModel(
                systemName: "star.fill",
                size: .medium,
                color: FluxColors.primary
            )

            // 2. Pass it to the View
            FluxIcon(viewModel: vm)

            // 3. Update dynamically
            vm.systemName = "heart.fill"
            vm.color = FluxColors.error
            """)
            .font(.system(.caption, design: .monospaced))
            .padding(FluxSpacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(FluxColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
        }
    }

    private func iconTile(_ vm: FluxIconViewModel, label: String) -> some View {
        VStack(spacing: FluxSpacing.xs) {
            FluxIcon(viewModel: vm)
            Text(label).font(FluxFont.caption).foregroundStyle(FluxColors.textSecondary)
        }
    }
}

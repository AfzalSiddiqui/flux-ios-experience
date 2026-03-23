import SwiftUI
import flux_ios_foundation

struct FluxGraphShowcase: View {
    @StateObject private var graphVM = FluxGraphViewModel(
        chartType: .bar,
        data: [
            FluxDataPoint(label: "Jan", value: 45), FluxDataPoint(label: "Feb", value: 72),
            FluxDataPoint(label: "Mar", value: 58), FluxDataPoint(label: "Apr", value: 90),
            FluxDataPoint(label: "May", value: 65), FluxDataPoint(label: "Jun", value: 83)
        ],
        title: "Monthly Revenue", showLabels: true, showValues: true
    )

    @State private var selectedType = 0
    @State private var showLabels = true
    @State private var showValues = true

    var body: some View {
        ScrollView {
            VStack(spacing: FluxSpacing.lg) {
                section("Chart Type") {
                    Picker("Type", selection: $selectedType) {
                        Text("Bar").tag(0)
                        Text("Line").tag(1)
                        Text("Pie").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedType) { newValue in
                        switch newValue {
                        case 0: graphVM.chartType = .bar
                        case 1: graphVM.chartType = .line
                        case 2: graphVM.chartType = .pie
                        default: break
                        }
                    }
                }
                section("Chart") {
                    FluxGraph(viewModel: graphVM)
                        .padding(FluxSpacing.md)
                        .background(FluxColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.md))
                }
                section("Options") {
                    Toggle("Show Labels", isOn: $showLabels)
                        .onChange(of: showLabels) { graphVM.showLabels = $0 }
                    Toggle("Show Values", isOn: $showValues)
                        .onChange(of: showValues) { graphVM.showValues = $0 }
                }
                usageSection
            }
            .padding(FluxSpacing.md)
        }
        .navigationTitle("FluxGraph")
    }

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: FluxSpacing.xs) {
            FluxText("How to Use", style: .headline)
            FluxText("""
            @StateObject var vm = FluxGraphViewModel(
                chartType: .bar,
                data: [
                    FluxDataPoint(label: "A", value: 45),
                    FluxDataPoint(label: "B", value: 72)
                ],
                title: "Chart Title",
                showLabels: true,
                showValues: true
            )

            FluxGraph(viewModel: vm)
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

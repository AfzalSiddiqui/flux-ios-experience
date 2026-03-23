import SwiftUI
import flux_ios_foundation

struct FluxWebViewShowcase: View {
    @StateObject private var webVM = FluxWebViewViewModel()
    @State private var urlInput = "https://apple.com"

    var body: some View {
        VStack(spacing: 0) {
            // URL Bar
            HStack(spacing: FluxSpacing.xs) {
                TextField("Enter URL", text: $urlInput)
                    .font(FluxFont.body)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button {
                    webVM.loadURL(urlInput)
                } label: {
                    FluxText("Load", style: .body, color: .white)
                        .padding(.horizontal, FluxSpacing.md)
                        .padding(.vertical, FluxSpacing.xs)
                        .background(FluxColors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: FluxRadius.sm))
                }
                .buttonStyle(.plain)
            }
            .padding(FluxSpacing.sm)

            if let title = webVM.title, !title.isEmpty {
                FluxText(title, style: .caption, color: FluxColors.textSecondary)
                    .lineLimit(1)
                    .padding(.horizontal, FluxSpacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            FluxWebView(viewModel: webVM)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("FluxWebView")
    }
}

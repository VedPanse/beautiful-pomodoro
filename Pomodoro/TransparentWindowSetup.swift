import SwiftUI

struct TransparentWindowSetup: View {
    var body: some View {
        Color.clear
            .background(TransparentWindowConfigurator())
    }
}

struct TransparentWindowConfigurator: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        DispatchQueue.main.async {
            if let window = NSApp.windows.first {
                window.titlebarAppearsTransparent = true
                window.isOpaque = false
                window.backgroundColor = .clear
                window.styleMask.insert(.fullSizeContentView)
            }
        }
        return NSView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

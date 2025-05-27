//
//  TransparentWindowSetup.swift
//  Pomodoro
//
//  Created by Ved Panse on 5/27/25.
//


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
                window.styleMask.remove(.titled) // ❌ remove title bar
                window.styleMask.remove(.resizable)
                window.styleMask.remove(.miniaturizable)
                window.styleMask.remove(.closable)
                                
                window.styleMask.insert(.fullSizeContentView)
                window.setContentSize(NSSize(width: 500, height: 600))
            }
        }
        return NSView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

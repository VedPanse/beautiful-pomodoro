//
//  DraggableHostingView.swift
//  Pomodoro
//
//  Created by Ved Panse on 5/27/25.
//


import Cocoa
import SwiftUI

class DraggableHostingView<Content>: NSHostingView<Content> where Content: View {
    private var initialLocation: NSPoint = .zero

    override func mouseDown(with event: NSEvent) {
        guard let window = self.window else { return }
        initialLocation = NSEvent.mouseLocation
        initialLocation.x -= window.frame.origin.x
        initialLocation.y -= window.frame.origin.y
    }

    override func mouseDragged(with event: NSEvent) {
        guard let window = self.window else { return }
        let currentLocation = NSEvent.mouseLocation
        var newOrigin = NSPoint(x: currentLocation.x - initialLocation.x,
                                y: currentLocation.y - initialLocation.y)
        window.setFrameOrigin(newOrigin)
    }
}

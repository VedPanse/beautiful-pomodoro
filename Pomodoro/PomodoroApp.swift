//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Ved Panse on 5/27/25.
//

import SwiftUI

@main
struct PomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView()
                .background(TransparentWindowSetup());
        }
    }
}

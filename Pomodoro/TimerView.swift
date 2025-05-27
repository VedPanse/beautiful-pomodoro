//
//  TimerView.swift
//  Pomodoro
//
//  Created by Ved Panse on 5/27/25.
//

import SwiftUI
import AVFoundation

enum PomodoroPhase {
    case work, shortBreak, longBreak
}

struct TimerView: View {
    @State private var timeRemaining = 25 * 60
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var animateTomato = false

    @State private var currentPhase: PomodoroPhase = .work
    @State private var pomodoroCount = 0
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            // 🍷 macOS acrylic effect
            VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                .overlay(Color.black.opacity(0.4))

            VStack(spacing: 30) {
                // Phase Label
                Text(phaseLabel())
                    .font(.title2)
                    .foregroundColor(.white)

                // Tomato Image
                Image("tomato")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaleEffect(animateTomato ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.8).repeatForever(), value: animateTomato)
                    .onAppear { animateTomato = true }

                // Timer Text
                Text(formatTime(timeRemaining))
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundColor(.white)

                // Play / Pause Buttons
                HStack(spacing: 40) {
                    if timerRunning {
                        Button(action: pauseTimer) {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        Button(action: startTimer) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
        }
    }

    func startTimer() {
        if timerRunning { return }
        timerRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
                playSound()
                handleTimerCompletion()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    func handleTimerCompletion() {
        switch currentPhase {
        case .work:
            pomodoroCount += 1
            if pomodoroCount % 4 == 0 {
                currentPhase = .longBreak
                timeRemaining = 20 * 60
            } else {
                currentPhase = .shortBreak
                timeRemaining = 5 * 60
            }

        case .shortBreak, .longBreak:
            currentPhase = .work
            timeRemaining = 25 * 60
        }
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }

    func phaseLabel() -> String {
        switch currentPhase {
        case .work: return "Focus Time"
        case .shortBreak: return "Short Break"
        case .longBreak: return "Long Break"
        }
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
}

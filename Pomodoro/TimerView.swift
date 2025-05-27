import SwiftUI

struct TimerView: View {
    @State private var timeRemaining = 25 * 60  // 25 minutes
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var animateTomato = false

    var body: some View {
        VStack(spacing: 30) {
            // Animated Tomato
            Image("tomato")
                .resizable()
                .frame(width: 120, height: 120)
                .scaleEffect(animateTomato ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.8).repeatForever(), value: animateTomato)
                .onAppear { animateTomato = true }

            // Time Display
            Text(formatTime(timeRemaining))
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()

            // Play/Pause Buttons
            HStack(spacing: 40) {
                Button(action: {
                    pauseTimer()
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                }

                Button(action: {
                    startTimer()
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
    }

    func startTimer() {
        if timerRunning { return }
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                pauseTimer()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

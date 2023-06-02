//
//  TimerView.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//
import Foundation
import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            Text("Player 1: \(timeString(from: viewModel.remainingTimePlayer1))")
                .font(.largeTitle)
            
            Text("Player 2: \(timeString(from: viewModel.remainingTimePlayer2))")
                .font(.largeTitle)
            
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.startTimer()
                }) {
                    Text("Start")
                }
                .disabled(viewModel.isTimerRunning)
                
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                }
                
                Button(action: {
                    viewModel.resetTimer()
                }) {
                    Text("Reset")
                }
            }
        }
        .padding()
        .alert(item: $viewModel.timesUpPlayer) { player in
            Alert(title: Text("Times UP"),
                  message: Text("Player \(player.rawValue) ran out of time!"),
                  dismissButton: .default(Text("OK")) {
                      viewModel.resetTimer()
                  })
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

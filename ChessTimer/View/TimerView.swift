//
//  TimerView.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import Foundation
import SwiftUI

struct TimerView: View {
//    let viewModel = TimerViewModel(totalTime: 300) // Example: 5 minutes
//    let timerView = TimerView(viewModel: viewModel)

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
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


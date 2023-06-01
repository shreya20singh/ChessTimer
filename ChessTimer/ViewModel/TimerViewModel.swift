//
//  TimerViewModel.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import Foundation

class TimerViewModel: ObservableObject {
    private var timerModel: TimerModel
    
    @Published var remainingTimePlayer1: TimeInterval {
        didSet {
            if remainingTimePlayer1 <= 0 {
                timerModel.pauseTimer()
                // Handle player 1 timeout or end of game
            }
        }
    }
    
    @Published var remainingTimePlayer2: TimeInterval {
        didSet {
            if remainingTimePlayer2 <= 0 {
                timerModel.pauseTimer()
                // Handle player 2 timeout or end of game
            }
        }
    }
    
    @Published var isTimerRunning: Bool = false
    
    init(totalTime: TimeInterval) {
        self.timerModel = TimerModel(totalTime: totalTime)
        self.remainingTimePlayer1 = totalTime
        self.remainingTimePlayer2 = totalTime
        
        self.timerModel.delegate = self
    }
    
    func startTimer() {
        timerModel.startTimer()
        isTimerRunning = true
    }
    
    func pauseTimer() {
        timerModel.pauseTimer()
        isTimerRunning = false
    }
    
    func resetTimer() {
        timerModel.resetTimer()
        remainingTimePlayer1 = timerModel.remainingTimePlayer1
        remainingTimePlayer2 = timerModel.remainingTimePlayer2
        isTimerRunning = false
    }
}

extension TimerViewModel: TimerModelDelegate {
    func timerDidStart() {
        // Additional logic if needed when the timer starts
    }
    
    func timerDidPause() {
        // Additional logic if needed when the timer pauses
    }
    
    func timerDidReset() {
        // Additional logic if needed when the timer resets
    }
    
    func timerDidUpdate() {
        remainingTimePlayer1 = timerModel.remainingTimePlayer1
        remainingTimePlayer2 = timerModel.remainingTimePlayer2
    }
    
    func timerDidEnd(for player: Player) {
        // Handle player timeout or end of game
    }
}

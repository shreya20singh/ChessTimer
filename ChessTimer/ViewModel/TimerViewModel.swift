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
                timerModel.pauseTimer(for: .player1)
                timesUpPlayer = .player1
            }
        }
    }
    
    @Published var remainingTimePlayer2: TimeInterval {
        didSet {
            if remainingTimePlayer2 <= 0 {
                timerModel.pauseTimer(for: .player2)
                timesUpPlayer = .player2
            }
        }
    }
    
    @Published var isTimerRunning: Bool = false
    @Published var timesUpPlayer: Player? = nil
    
    private var currentPlayer: Player = .player1
    
    init(totalTime: TimeInterval) {
        self.timerModel = TimerModel(totalTime: totalTime)
        self.remainingTimePlayer1 = totalTime
        self.remainingTimePlayer2 = totalTime
        
        self.timerModel.delegate = self
    }
    
    func startTimer() {
        if isTimerRunning {
            return
        }
        
        if remainingTimePlayer1 <= 0 || remainingTimePlayer2 <= 0 {
            resetTimer()
        }
        
        switch currentPlayer {
        case .player1:
            timerModel.startTimer(for: .player1)
        case .player2:
            timerModel.startTimer(for: .player2)
        }
        
        isTimerRunning = true
    }
    
    func pauseTimer() {
        switch currentPlayer {
        case .player1:
            timerModel.pauseTimer(for: .player1)
            timerModel.startTimer(for: .player2)
        case .player2:
            timerModel.pauseTimer(for: .player2)
            timerModel.startTimer(for: .player1)
        }
        
        currentPlayer = currentPlayer == .player1 ? .player2 : .player1
    }
    
    func resetTimer() {
        timerModel.resetTimer()
        remainingTimePlayer1 = timerModel.remainingTimePlayer1
        remainingTimePlayer2 = timerModel.remainingTimePlayer2
        isTimerRunning = false
        currentPlayer = .player1
    }
}

extension TimerViewModel: TimerModelDelegate {
    func timerDidStart(for player: Player) {
        // Additional logic if needed when the timer starts
    }
    
    func timerDidPause(for player: Player) {
        // Additional logic if needed when the timer pauses
    }
    
    func timerDidReset() {
        // Additional logic if needed when the timer resets
    }
    
    func timerDidUpdate(for player: Player) {
        switch player {
        case .player1:
            remainingTimePlayer1 = timerModel.remainingTimePlayer1
        case .player2:
            remainingTimePlayer2 = timerModel.remainingTimePlayer2
        }
    }
    
    func timerDidEnd(for player: Player) {
        // Handle player timeout or end of game
    }
}

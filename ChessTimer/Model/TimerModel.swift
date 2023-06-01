//
//  TimerModel.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import Foundation

class TimerModel {
    private var totalTime: TimeInterval
    private var currentPlayer: Player
    private var player1Time: TimeInterval
    private var player2Time: TimeInterval
    
    private var timer: Timer?
    
    var delegate: TimerModelDelegate?
    
    var remainingTimePlayer1: TimeInterval {
        return player1Time
    }
    
    var remainingTimePlayer2: TimeInterval {
        return player2Time
    }
    
    var isTimerRunning: Bool {
        return timer != nil && timer!.isValid
    }
    
    init(totalTime: TimeInterval) {
        self.totalTime = totalTime
        self.currentPlayer = .player1
        self.player1Time = totalTime
        self.player2Time = totalTime
    }
    
    func startTimer() {
        guard !isTimerRunning else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.updateTimer()
        }
        
        delegate?.timerDidStart()
    }
    
    func pauseTimer() {
        guard isTimerRunning else { return }
        
        timer?.invalidate()
        timer = nil
        
        delegate?.timerDidPause()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        
        currentPlayer = .player1
        player1Time = totalTime
        player2Time = totalTime
        
        delegate?.timerDidReset()
    }
    
    private func updateTimer() {
        switch currentPlayer {
        case .player1:
            player1Time -= 1.0
            if player1Time <= 0 {
                delegate?.timerDidEnd(for: .player1)
                return
            }
        case .player2:
            player2Time -= 1.0
            if player2Time <= 0 {
                delegate?.timerDidEnd(for: .player2)
                return
            }
        }
        
        delegate?.timerDidUpdate()
        
        currentPlayer = (currentPlayer == .player1) ? .player2 : .player1
    }
}

enum Player {
    case player1
    case player2
}

protocol TimerModelDelegate: AnyObject {
    func timerDidStart()
    func timerDidPause()
    func timerDidReset()
    func timerDidUpdate()
    func timerDidEnd(for player: Player)
}

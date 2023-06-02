//
//  TimerModel.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import Foundation

class TimerModel {
    private var totalTime: TimeInterval
    private var player1Timer: Timer?
    private var player2Timer: Timer?
    
    private var player1Time: TimeInterval
    private var player2Time: TimeInterval
    
    var delegate: TimerModelDelegate?
    
    var remainingTimePlayer1: TimeInterval {
        return player1Time
    }
    
    var remainingTimePlayer2: TimeInterval {
        return player2Time
    }
    
    var isTimerRunningPlayer1: Bool {
        return player1Timer != nil && player1Timer!.isValid
    }
    
    var isTimerRunningPlayer2: Bool {
        return player2Timer != nil && player2Timer!.isValid
    }
    
    init(totalTime: TimeInterval) {
        self.totalTime = totalTime
        self.player1Time = totalTime
        self.player2Time = totalTime
    }
    
    func startTimer(for player: Player) {
        switch player {
        case .player1:
            guard !isTimerRunningPlayer1 else { return }
            player1Timer = createTimer(for: .player1)
            delegate?.timerDidStart(for: .player1)
        case .player2:
            guard !isTimerRunningPlayer2 else { return }
            player2Timer = createTimer(for: .player2)
            delegate?.timerDidStart(for: .player2)
        }
    }
    
    func pauseTimer(for player: Player) {
        switch player {
        case .player1:
            guard isTimerRunningPlayer1 else { return }
            player1Timer?.invalidate()
            player1Timer = nil
            delegate?.timerDidPause(for: .player1)
        case .player2:
            guard isTimerRunningPlayer2 else { return }
            player2Timer?.invalidate()
            player2Timer = nil
            delegate?.timerDidPause(for: .player2)
        }
    }
    
    func resetTimer() {
        player1Timer?.invalidate()
        player1Timer = nil
        player2Timer?.invalidate()
        player2Timer = nil
        
        player1Time = totalTime
        player2Time = totalTime
        
        delegate?.timerDidReset()
    }
    
    private func createTimer(for player: Player) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.updateTimer(for: player)
        }
    }
    
    private func updateTimer(for player: Player) {
        switch player {
        case .player1:
            player1Time -= 1.0
            if player1Time <= 0.01 {
                delegate?.timerDidEnd(for: .player1)
                player1Timer?.invalidate()
                player1Timer = nil
                return
            }
        case .player2:
            player2Time -= 1.0
            if player2Time <= 0.01 {
                delegate?.timerDidEnd(for: .player2)
                player2Timer?.invalidate()
                player2Timer = nil
                return
            }
        }
        
        delegate?.timerDidUpdate(for: player)
    }
}

enum Player: Int, Identifiable {
    case player1 = 1
    case player2 = 2
        
    var id: Int {
        return self.rawValue
    }
}

protocol TimerModelDelegate: AnyObject {
    func timerDidStart(for player: Player)
    func timerDidPause(for player: Player)
    func timerDidReset()
    func timerDidUpdate(for player: Player)
    func timerDidEnd(for player: Player)
}

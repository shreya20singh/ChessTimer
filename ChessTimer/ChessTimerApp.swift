//
//  ChessTimerApp.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import SwiftUI

@main
struct ChessTimerApp: App {
    var viewModel: TimerViewModel = TimerViewModel(totalTime: 300) // Example: 5 minutes
    
    var body: some Scene {
        WindowGroup {
            TimerView(viewModel: viewModel)
        }
    }
}


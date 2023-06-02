//
//  ContentView.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import SwiftUI

struct ContentView: View {
    @State private var totalTime: TimeInterval = 300
    
    var body: some View {
        VStack {
            if totalTime == 0 {
                TimerSetupView(totalTime: $totalTime)
            } else {
                TimerView(viewModel: TimerViewModel(totalTime: totalTime))
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

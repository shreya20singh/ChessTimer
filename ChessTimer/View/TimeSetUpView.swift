//
//  TimeSetUpView.swift
//  ChessTimer
//
//  Created by Aerologix Aerologix on 6/1/23.
//

import Foundation
import SwiftUI

struct TimerSetupView: View {
    @Binding var totalTime: TimeInterval
    @State private var timeInput: String = ""
    @State private var redirectToTimer: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter Total Time (minutes)")
                    .font(.title)
                    .padding()
                
                TextField("Enter time", text: $timeInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if let time = Int(timeInput) {
                        totalTime = TimeInterval(time * 60)
                        redirectToTimer = true
                    } else {
                        // Show an error message or handle invalid input
                    }
                }) {
                    Text("Go")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Timer Setup")
            .background(
                NavigationLink(
                    destination: TimerView(viewModel: TimerViewModel(totalTime: totalTime)),
                    isActive: .constant(redirectToTimer)
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .frame(width: 400, height: 300) // Adjust the window size as needed
    }
}

//
//  TestTimerView.swift
//  Planty
//
//  Created by Muhammad Rezky on 07/07/23.
//

import SwiftUI

struct TestTimerView: View {
    @State private var startTime: Date?
    @State private var totalTime: TimeInterval = 0
    @State private var totalTemp: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    
    init(){
        if let lastStartTime = UserDefaults.standard.object(forKey: "lastStartTimeKey") as? Date {
            startTime = lastStartTime
        }
    }
    
    var body: some View {
        VStack {
            Text(timeString(from: totalTime + totalTemp))
                .font(.largeTitle)
                .padding()
            
            HStack {
                if isTimerRunning {
                    Button(action: pauseTimer) {
                        Text("Pause")
                            .font(.title)
                            .padding()
                    }
                } else {
                    Button(action: startTimer) {
                        Text("Start")
                            .font(.title)
                            .padding()
                    }
                }
       
            }
        }
        .onDisappear {
            print("disappear")
        }
    }
    
    func startTimer() {
        startTime = Date()
        UserDefaults.standard.set(startTime, forKey: "lastStartTimeKey")

        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let startTime = startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                totalTemp = elapsedTime
            }
        }
    }

    
    func pauseTimer() {
        UserDefaults.standard.removeObject(forKey: "lastStartTimeKey")

        isTimerRunning = false
        startTime = nil
        totalTime += totalTemp
        totalTemp = 0
    }
    

    func timeString(from timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
}




//struct TestTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestTimerView()
//    }
//}

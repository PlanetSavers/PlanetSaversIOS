//
//  CycleTaskView.swift
//  Planty
//
//  Created by Muhammad Rezky on 07/07/23.
//

import SwiftUI


struct TimerData: Codable {
    var totalTime: TimeInterval
    var startTime: Date?
    var isTimerRunning: Bool
}


struct CycleTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var task: Taskx
    @Binding var data: TaskData?
    @State var showImpact: Bool = true
    @State private var progress: Double = 0
    @State private var totalTemp: TimeInterval = 0
    @State private var timerData: TimerData = TimerData(totalTime: 0, isTimerRunning: false)
    @State private var timer: Timer?
    
    
    func saveTimerData(_ timerData: TimerData, _ key: String) {
        do {
            let encodedData = try JSONEncoder().encode(timerData)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            print("Error encoding TimerData: \(error)")
        }
    }
    
    // Get TimerData
    func getTimerData(_ key: String) -> TimerData? {
        if let encodedData = UserDefaults.standard.data(forKey: key) {
            do {
                let timerData = try JSONDecoder().decode(TimerData.self, from: encodedData)
                return timerData
            } catch {
                print("Error decoding TimerData: \(error)")
            }
        }
        return nil
    }
    
    // Delete TimerData
    func deleteTimerData() {
        UserDefaults.standard.removeObject(forKey: "timerData")
    }
    
    var body: some View {
        if(data == nil){
            Color.white
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $showImpact){
                    TaskImpactView(task: task, taskData: $data, isPresented: $showImpact)
                }
                .onChange(of: showImpact){_ in
                    if(data == nil){
                            presentationMode.wrappedValue.dismiss()
                    }
                }
        }
        if(data != nil) {
            Color.white
            .onAppear{
                let temp = getTimerData(data!.documentId)
                print("bismillah \(temp)")
                if(temp != nil){
                    self.timerData = temp!
                    if(self.timerData.isTimerRunning){
                        firingTimer()
                    }
                }
                
                    
            }
            VStack(spacing: 0){
                ZStack(alignment: .top){
                    Image("cycle-background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    VStack{
                        HStack(alignment: .top){
                            VStack(alignment: .leading, spacing: 4){
                                Text("Target Bersepeda")
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .frame(alignment: .leading)
                                Text(timeString(from: TimeInterval(task.target)))
                                
                                .font(.system(size: 40, weight: .semibold, design: .rounded))
                            }
                            Spacer()
                            Button{
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            }
                        }
                        .padding(16)
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                        Spacer()
                        ZStack(alignment: .center){
                            Rectangle()
                                .background(.white)
                                .foregroundColor(.white)
                                .frame(width: 255, height: 255)
                                .cornerRadius(1000)
                            CircularProgressView(progress: $progress)
                                .frame(width: 200, height: 200)
                            VStack{
                                Text("Waktu")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                
                                Text(timeString(from: timerData.totalTime + totalTemp))
                                
                                .font(.system(size: 35, weight: .semibold, design: .rounded))
                                    .kerning(0.46072)
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    .padding(16)
                    
                    
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - 100)
                    .background(.red)
                VStack(alignment: .center){
                    if(progress < 1){
                        Button{
                            if timerData.isTimerRunning{
                                pauseTimer()
                            } else {
                                startTimer()
                            }
                        } label: {
                            Text(!timerData.isTimerRunning ? "Mulai Bersepeda" : "Berhenti Bersepeda")
                            
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                                .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                                .cornerRadius(99)
                        }
                        .padding(16)
                    } else {
                        Button{
                            finishTask()
                        } label: {
                            Text("Selesaikan Task")
                            
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                                .background(Color("brown400"))
                                .cornerRadius(99)
                        }
                        .padding(16)
                        .onAppear{
                            pauseTimer()
                        }
                    }
                    
                }
                .frame(maxHeight: 70)
                .background(.white)
                .fullScreenCover(isPresented: $showImpact){
                    TaskImpactView(task: task, taskData: $data, isPresented: $showImpact)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            
            .navigationBarHidden(true)
        }
        
    }
    
    func finishTask() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        if(progress >= 1){
            FirebaseManager.shared.firestore.collection("users").document(uid).collection("task").document(task.documentId).updateData([
                "progress" : task.target
            ]){error in
                print(error)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func startTimer() {
        if(timerData.startTime == nil){
            timerData.startTime = Date()
        }
        
        timerData.isTimerRunning = true
        saveTimerData(timerData, task.documentId)
        
        firingTimer()
        
    }
    
    func firingTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let startTime = timerData.startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                totalTemp = elapsedTime
            }
            self.progress = Double(timerData.totalTime + totalTemp) / Double(task.target)
        }
    }
    
    
    func pauseTimer() {
        
        timerData.isTimerRunning = false
        timerData.startTime = nil
        timerData.totalTime += totalTemp
        saveTimerData(timerData,task.documentId)
        
        totalTemp = 0
    }
    
    
    
}

func timeString(from timeInterval: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: timeInterval) ?? "00:00:00"
}
//
//struct CycleTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        CycleTaskView(
//
//            task: Taskx(
//                documentId: "cycl1",
//                title: "Bersepeda",
//                description: "Deskripsi",
//                type: "cycle",
//                progress: 0,
//                target: 100
//            ),
//            data: TaskData(
//                documentId: "cycl1",
//                progress: 0,
//                target: 100,
//                image: ""
//            )
//        )
//    }
//}

//
//  CycleImpactView.swift
//  Planty
//
//  Created by Muhammad Rezky on 07/07/23.
//

import SwiftUI

struct TaskImpactView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var task: Taskx
    @Binding var taskData: TaskData?
    @Binding var isPresented: Bool
    
    
    func getTitle() -> String {
        switch task.type {
        case "cycle" :
            return "Waktu"
        case "walk", "run", "cycle":
            return  "Jarak"
        default:
            return "Penyelesaian"
        }
    }
    
    func getProgress() -> String {
        switch task.type {
        case "cycle" :
            return timeString(from: TimeInterval(taskData!.progress))
        default:
            return "\(taskData!.progress)"
        }
    }
    
    func getTarget() -> String {
        switch task.type {
        case "cycle" :
            return  timeString(from: TimeInterval(taskData!.target))
        default:
            return  "\(taskData!.target)"
        }
    }
    
    func getProgress() -> Double {
        return Double( Double(taskData!.progress) / Double(taskData!.target) )
    }
    
    
    func startTask(task: Taskx) async {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        do {
            try await FirebaseManager.shared.firestore.collection("users").document(uid).collection("task").document(task.documentId).setData([
                "document_id": task.documentId,
                "progress": task.progress,
                "target": task.target, // harusnya target dari task yang direferensiin
                "image": "",
            ])
            taskData = TaskData(dictionary: [
                "document_id": task.documentId,
                "progress": task.progress,
                "target": task.target, // harusnya target dari task yang direferensiin
                "image": "",
            ])
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            ZStack(alignment: .top){
                Image("cycle-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack(spacing: 24){
                    HStack{
                        Spacer()
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.white.opacity(0.5))
                                    .cornerRadius(100)
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(task.title)
                        
                            .lineSpacing(8)
                            .font(.system(size: 17,weight: .semibold, design: .rounded))
                        Text(task.description)
                            .lineSpacing(4)
                        
                        .font(.system(size: 15, design: .rounded))
                            .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.22))
                        
                        
                    }
                    .padding(16)
                    .frame(width: 358, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(20)
                    HStack{
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dampak yang didapat")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                            Text("4,7kgCO2e")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .kerning(0.38)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.15, green: 0.65, blue: 0.51))
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dampak yang didapat")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                            Text("4,7kgCO2e")
                            
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                .kerning(0.38)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.15, green: 0.65, blue: 0.51))
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 32)
            }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - 180)
                .background(.red)
            VStack(alignment: .center){
                if(taskData == nil){
                    Button{
                        Task{
                            await startTask(task: task)
                            isPresented = false
                        }
                    } label: {
                        Text("Lakukan Aksi")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                            .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                            .cornerRadius(99)
                    }
                } else {
                    VStack{
                        HStack(){
                            Text(getTitle())
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            Spacer()
                            Text("\(getProgress()) / \(getTarget())")
                            
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            
                        }
                        .padding(.bottom, 4)
                        Gauge(value: getProgress()){
                            EmptyView()
                        }
                        .tint(Color("green600"))
                        .background(Color("green100"))
                        .frame(height: 8)
                        .cornerRadius(100)
                    }
                }
                
            }
            .padding(.horizontal, 16)
            .frame(maxHeight: 180, alignment: .center)
            .background(.white)
        }
        .navigationBarHidden(true)
        
    }
}

//struct CycleImpactView_Previews: PreviewProvider {
//    static var previews: some View {
//        CycleImpactView()
//    }
//}

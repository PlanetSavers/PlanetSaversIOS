//
//  GroupTaskView.swift
//  Planty
//
//  Created by Muhammad Rezky on 06/07/23.
//

import SwiftUI

struct TaskCardView: View {
    var task: Taskx
    var taskData: TaskData?
    
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
        } catch {
            print(error)
        }
    }
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 20){
                Rectangle()
                    .frame(width: 64, height: 64)
                    .foregroundColor(Color("brown400"))
                    .cornerRadius(12)
                VStack(alignment: .leading, spacing: 4){
                    Text(task.title)
                    
                    
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    Text(task.subtitle)
                        .lineSpacing(8)
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(Color(red: 0.4, green: 0.44, blue: 0.52))
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            if(taskData == nil){
                Button{
                    Task{
                        await startTask(task: task)
                    }
                } label: {
                    Text("Lakukan Aksi")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
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
        .padding(16)
        .frame(width: 358, alignment: .topLeading)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 7.5, x: 5, y: 10)
        .shadow(color: .black.opacity(0.02), radius: 10, x: -5, y: -5)
        
    }
}

struct GroupTaskView: View {

    @State var selectedTaskDataModel: TaskData? = nil
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var goToWalkTask: Bool = false
    @State var goToCycleTask: Bool = false
    @State var goToBaseTask: Bool = false
    @State var selectedTaskxModel: Taskx? = nil
    

    
    func getUserTask(documentId: String) -> TaskData? {
        return userViewModel.taskDatas.first { $0.documentId == documentId }
    }
    
    private func checkFinishedTask(task: Taskx) -> Bool{
        let taskData : TaskData? = userViewModel.taskDatas.first { $0.documentId == task.documentId }
        if(taskData == nil){
            return false
        } else if (taskData!.progress >= task.target){
            return true
        } else {
            return false
        }
    }
    
    private func getTaskFinishedCount() -> Int{
        var count = 0
        for task in userViewModel.selectedGroupTask!.tasks {
            let result = checkFinishedTask(task: task)
            if(result == true){
                count += 1
            }
        }
        return count
    }
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ZStack(alignment: .top){
                    Image("\(userViewModel.selectedGroupTask!.documentId)-banner")
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading){
                        Spacer().frame(height: 32)
                        Text(userViewModel.selectedGroupTask!.title)
                            .multilineTextAlignment(.leading)
                            .frame(width: UIScreen.main.bounds.width/2 - 32)
                        
                        .font(.system(size: 28, weight: .medium, design: .rounded))
                            .kerning(0.364)
                        Text("\(userViewModel.selectedGroupTask!.tasks.count) Task")
                            .font(.system(size: 15, design: .rounded))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(.white)
                            .cornerRadius(100)
                            .padding(.bottom, 24)
                        VStack{
                            HStack(){
                                Text("Task yang diselesaikan")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                Spacer()
                                Text("\(getTaskFinishedCount()) / \(userViewModel.selectedGroupTask!.tasks.count)")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                
                            }.padding(.bottom, 12)
                            Gauge(value:Float(getTaskFinishedCount()) / Float(userViewModel.selectedGroupTask!.tasks.count)){
                                EmptyView()
                            }
                            .tint(Color("green600"))
                            .background(Color("green100"))
                            .frame(height: 8)
                            .cornerRadius(100)
                            
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity,maxHeight: 80)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.05), radius: 7.5, x: 5, y: 10)
                        .shadow(color: .black.opacity(0.02), radius: 10, x: -5, y: -5)
                    }
                    .padding(.horizontal, 20)
                }
                VStack(alignment: .leading){
                    Text(userViewModel.selectedGroupTask!.description)
                        .lineSpacing(8)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .padding(.bottom, 14)
                    Button{} label: {
                        HStack{
                            Image(systemName: "info.circle")
                            Text("Apa dampak yang diberikan?")
                                .font(.system(size: 15, design: .rounded))
                        }
                    }
                    .foregroundColor(Color(red: 0.15, green: 0.65, blue: 0.51))
                    .padding(.bottom, 16)
                    
                    Text("Aksi yang bisa kamu lakukan")
                    
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                        .kerning(0.35)
                        .padding(.bottom, 16)
                    
                    if(selectedTaskxModel != nil){
                        NavigationLink(destination: CycleTaskView(task: selectedTaskxModel!, data: $selectedTaskDataModel), isActive: $goToCycleTask){
                            EmptyView()
                        }
                        NavigationLink(destination: BaseTaskView(task: selectedTaskxModel!, data: $selectedTaskDataModel), isActive: $goToBaseTask){
                            EmptyView()
                        }
                    }
                    
                    ForEach(userViewModel.selectedGroupTask!.tasks, id: \.self){taskx in
                        TaskCardView(
                            task: taskx,
                            taskData: getUserTask(documentId: taskx.documentId)
                        ).onTapGesture {
                            selectedTaskxModel = taskx
                            selectedTaskDataModel = getUserTask(documentId: taskx.documentId)
                            switch taskx.type {
                            case "walk":
                                goToWalkTask.toggle()
                            case  "cycle":
                                goToCycleTask.toggle()
                            case "base":
                                goToBaseTask.toggle()
                            default:
                                goToWalkTask.toggle()
                            }
                        }
                        Spacer().frame(height: 16)
                        
                    }
                    
                    
                }
                .padding(16)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        
        .navigationTitle(userViewModel.selectedGroupTask!.title)
        .navigationBarHidden(false)
        
    }
}

//struct GroupTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupTaskView(
//            groupTask: GroupTask(
//                documentId: "",
//                title: "Asap Polusi",
//                description: "Lorem ipsum dolor sit amet consectetur. Ut erat lectus nisl elementum libero fames lobortis. Tempor eleifend fusce a pulvinar sed ornare nec consequat vulputate. Lacus malesuada aliquam ut feugiat.",
//                image: "",
//                tasks: [
//                    Taskx(
//                        documentId: "-",
//                        title: "Bersepeda",
//                        description: "Berdepeda selama 2 jam",
//                        type: "cycle",
//                        progress: 0,
//                        target: 1
//                    ),
//                    Taskx(
//                        documentId: "-",
//                        title: "Berjalan",
//                        description: "Berjalan sebanyak 1000 langkah",
//                        type: "walk",
//                        progress: 0,
//                        target: 1
//                    )
//                ]
//            )
//        )
//    }
//}

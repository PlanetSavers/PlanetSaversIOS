//
//  HomeView.swift
//  Planty
//
//  Created by Muhammad Rezky on 08/07/23.
//

import SwiftUI

struct HomeView: View {
    @State var showActionSheet = false
    @State var showActionSheetProfile = false
    @State var navigateToAuthPage = false
    
    let columns = [
        GridItem(.adaptive(minimum: 164))
    ]
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var goToGroupTaskView = false
    @State var selectedGroupTask: GroupTask? = nil
    
    func getTaskx(_ documentId: String) -> Taskx? {
        return userViewModel.islands.first!.groupTasks
            .flatMap { $0.tasks }
            .first { $0.documentId == documentId }
    }
    
    func isCompleted(_ objectName: String) -> Bool{
        switch objectName{
        case "landscape-1":
            return checkCompletion("task5")
        case "landscape-2":
            return checkCompletion("task5")
        case "cars-object":
            return checkCompletion("task3")
        case "bus-object":
            return checkCompletion("task3")
        case "trash-object":
            return checkCompletion("task6")
        case "river-bad-object":
            return checkCompletion("task7")
        case "forest-bad-object":
            return checkCompletion("task4")
        case "forest-good-object":
            return checkCompletion("task4")
        case "cycles-object":
            return checkCompletion("task1")
        case "walk-object":
            return checkCompletion("task2")
        case "trashbin-object":
            return checkCompletion("task8")
        default:
            return true
        }
    }
    
    func getUserTask(_ documentId: String) -> TaskData? {
        return userViewModel.taskDatas.first { $0.documentId == documentId }
    }
    
    
    func checkCompletion(_ documentId: String) -> Bool{
        guard let task = getTaskx(documentId) else {return false}
        guard let taskData = getUserTask(documentId) else {return false}
        print("------")
        print(task.documentId)
        print(taskData.progress)
        print(task.target)
        if(taskData.progress >= task.target){
            return true
        } else {
            return false
        }
        
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
    
    private func getTaskFinishedCount(_  selectedGroupTask: GroupTask) -> Int{
        var count = 0
        for task in selectedGroupTask.tasks {
            let result = checkFinishedTask(task: task)
            if(result == true){
                count += 1
            }
        }
        return count
    }
    
    
    
    func getCompletionTaskCount() -> Int{
        var count = 0
        for index in 1...8 {
            if(checkCompletion("task\(index)")){
                count += 1
            }
        }
        return count
    }
    
    var body: some View {
        if(userViewModel.state == .loaded){

                VStack{
                    NavigationLink( destination: GroupTaskView().environmentObject(userViewModel), isActive: $goToGroupTaskView){
                        EmptyView()
                    }
                    HStack(alignment: .top,spacing: 16){
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Pulau")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                            HStack{
                                Text("Pertama")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.down.circle")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width * 1.5/3, alignment: .topLeading)
                        .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                        .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Aksi Selesai")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.black)
                            HStack{
                                Text("\(getCompletionTaskCount()) / 8")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("green600"))
                                Spacer()
                                Image(systemName: "arrow.down.circle")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                    }.frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 64)
                    
                    Spacer()
                    ZStack(alignment: .center){
                        ZStack(alignment: .center){
                            Image("landscape-1")
                                .opacity(!isCompleted("landscape-1") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("cars-object")
                                .opacity(!isCompleted("cars-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("trash-object")
                                .opacity(!isCompleted("trash-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("river-bad-object")
                                .opacity(!isCompleted("river-bad-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("forest-bad-object")
                                .opacity(!isCompleted("forest-bad-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                        }
                        ZStack(alignment: .center){
                            Image("landscape-2")
                                .opacity(isCompleted("landscape-2") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("cycles-object")
                                .opacity(isCompleted("cycles-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("walk-object")
                                .opacity(isCompleted("walk-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("forest-good-object")
                                .opacity(isCompleted("forest-good-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("trashbin-object")
                                .opacity(isCompleted("trashbin-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                            Image("bus-object")
                                .opacity(isCompleted("bus-object") ? 1 : 0)
                                .animation(.easeIn(duration: 2))
                        }
                    }
                    Spacer()
                    HStack(alignment: .center, spacing: 2) {
                        VStack(spacing: 6){
                            Image(systemName: "square.dashed")
                            Text("Island")
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("green600"))
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 6){
                            Image(systemName: "square.dashed")
                            Text("Action")
                            
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .opacity(0.5)
                        
                        .sheet(isPresented: $showActionSheet){
                            ScrollView{
                                VStack(alignment: .leading, spacing: 0){
                                    
                                    Text("Ayo Selamatkan Pulau Pertama !")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .kerning(0.364)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 8)
                                    Text("Aksi nyata yang bisa kamu lakukan untuk meminimalisir perubahan iklim")
                                        .font(.system(size: 16, weight: .regular, design: .rounded))
                                        .lineSpacing(4)
                                        .padding(.bottom, 24)
                                        .padding(.horizontal, 8)
                                    
                                    LazyVGrid(columns: columns, spacing: 16) {
                                        ForEach(userViewModel.islands.first!.groupTasks, id: \.self) { groupTask in
                                            var  _ = print(groupTask)
                                            ZStack{
                                                Image("\(groupTask.documentId)-tumbnail")
                                                    .resizable()
                                                    .frame( width: UIScreen.main.bounds.width/2 - 28, height: 216)
                                                    .foregroundColor(.gray)
                                                    .cornerRadius(16)
                                                VStack(alignment: .leading){
                                                    // Headline/Semibold
                                                    Text(groupTask.title)
                                                    
                                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.white)
                                                        .padding(.bottom, 8)
                                                    Gauge(value: Float(getTaskFinishedCount(groupTask)) / Float(groupTask.tasks.count)){
                                                        EmptyView()
                                                    }
                                                    .tint(Color.white)
                                                    .background(Color.black.opacity(0.2))
                                                    .frame(height: 6)
                                                    .cornerRadius(100)
                                                    
                                                }
                                                .padding(16)
                                                .frame(maxWidth: UIScreen.main.bounds.width/2 - 28, maxHeight: 216,alignment: .topLeading)
                                            }
                                            .onTapGesture {
                                                showActionSheet.toggle()
                                                goToGroupTaskView.toggle()
                                                userViewModel.selectedGroupTask = groupTask
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 24)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .presentationDetents([.medium, .large])
                            
                        }
                        .onTapGesture {
                            showActionSheet.toggle()
                        }
                        
                        VStack(spacing: 6){
                            Image(systemName: "square.dashed")
                            Text("Profile")
                            
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .opacity(0.5)
                        .sheet(isPresented: $showActionSheetProfile){
                            Button{
                                Task{
                                    try     await  FirebaseManager.shared.auth.signOut()
                                }
                            } label: {
                                Text("Log Out")
                            }
                        }
                        .onTapGesture{
                            showActionSheetProfile.toggle()
                            
                        }
                        VStack(spacing: 6){
                            Image(systemName: "square.dashed")
                            Text("Discover")
                            
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .opacity(0.5)
                        
                    }
                    .padding(.horizontal, 26)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(99)
                }
                .padding(16)
                .background(
                    getCompletionTaskCount() >= 8
                    ? Image("island1-background-after")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                        .ignoresSafeArea()
                    : Image("island1-background-before")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                            .ignoresSafeArea()
                    
                )
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height )
                .edgesIgnoringSafeArea(.all)
                
            
        } else {
            ProgressView()
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

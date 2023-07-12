//
//  UserView.swift
//  Planty
//
//  Created by Muhammad Rezky on 04/07/23.
//

import SwiftUI
import Combine
import Firebase

enum ViewState {
    case loading
    case loaded
    case empty
    case error
}

enum TaskxStatus{
    case empty
    case progress
    case completed
}
//
//struct UserView: View {
//    var cancellables = Set<AnyCancellable>()
//    @State var islands: [Island] = []
//    @State var taskDatas: [TaskData] = []
//    @State var state: ViewState = ViewState.empty
//
//    func getUserTask(documentId: String) -> TaskData? {
//        return taskDatas.first { $0.documentId == documentId }
//
//    }
//
//    func fetchUserTask() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//        FirebaseManager.shared.firestore.collection("users").document(uid).collection("task")
//            .addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                    print("Error fetching user tasks: \(error)")
//                    return
//                }
//
//                guard let documents = querySnapshot?.documents else {
//                    return
//                }
//
//                print("update")
//
//                var updatedTaskDatas: [TaskData] = []
//
//                for document in documents {
//                    let snapshot = document.data()
//                    let taskData = TaskData(dictionary: snapshot)
//                    updatedTaskDatas.append(taskData)
//                }
//
//                self.taskDatas = updatedTaskDatas
//            }
//    }
//
//
//
//    func fetchData() async -> [Island] {
//        var islandDatas: [Island] = []
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return []}
//        do{
//            let snapshot = try await FirebaseManager.shared.firestore.collection("users").document(uid).getDocument()
//            if let data = snapshot.data() {
//                if let islands = data["island"] as? [DocumentReference]{
//                    for island in islands {
//                        islandDatas.append(await fetchIsland(island))
//                    }
//                }
//            }
//            return islandDatas
//        } catch {
//            print(error)
//        }
//        return islandDatas
//    }
//
//    func fetchIsland(_ ref: DocumentReference) async -> Island{
//        do {
//            var island: Island = Island()
//            let snapshot = try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
//            if let data = snapshot.data() {
//                island.documentId = data["document_id"] as! String
//                if let groupTasks = data["group_tasks"] as? [DocumentReference]{
//                    for group in groupTasks {
//                        island.groupTasks.append(await fetchGroupTask(group))
//                    }
//                }
//            }
//            return island
//        } catch {
//            print(error)
//            return Island()
//        }
//    }
//
//    func fetchGroupTask(_ ref: DocumentReference) async  -> GroupTask{
//        do {
//            var groupTask: GroupTask = GroupTask()
//            let snapshot =  try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
//
//            if let data = snapshot.data() {
//                groupTask = GroupTask(dictionary: data)
//                if let tasks = data["tasks"] as? [DocumentReference]{
//                    for task in tasks {
//                        groupTask.tasks.append(await fetchTask(task))
//                    }
//                }
//            }
//            return groupTask
//        } catch {
//            print(error)
//            return GroupTask()
//        }
//    }
//
//    func fetchTask(_ ref: DocumentReference) async -> Taskx {
//        do{
//            let snapshot = try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
//            return Taskx(dictionary: snapshot.data()!)
//        } catch {
//            print(error)
//            return Taskx()
//        }
//    }
//
//
//
//    func loadData() async {
//        state = .loading
//        let result =  await fetchData()
//        await fetchUserTask()
//        DispatchQueue.main.async {
//            self.islands = result
//        }
//        state = .loaded
//
//    }
//    @State var navigateToGroupTaskView = false
//
//    var body: some View {
//
//        NavigationView{
//            ScrollView(){
//                Button{
//                    Task{
//                        await loadData()
//                    }
//                } label: {
//                    Text("fetch data")
//                        .padding(.vertical, 16)
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(.white)
//                        .background(.blue)
//                }
//                switch state {
//                case .loading:
//                    ProgressView()
//                case .loaded, .empty:
//                    VStack(alignment: .leading){
//                        ForEach(islands, id: \.self) { island in
//                            Text("Island document_id : \(island.documentId)")
//                            VStack(alignment: .leading, spacing: 10){
//
//                                ForEach(island.groupTasks, id: \.self){groupTask in
//                                        NavigationLink( destination: GroupTaskView(
//                                            groupTask: groupTask, taskDatas: taskDatas)){
//
//                                    VStack{
//                                        Text("Task Group document_id : \(groupTask.documentId)")
//                                        Text("List Task")
//
//                                        VStack(alignment: .leading, spacing: 16){
//                                            ForEach(groupTask.tasks, id: \.self){taskx in
//                                                VStack(alignment: .leading, spacing: 4){
//                                                    Text("Task document_id : \(taskx.documentId)")
//                                                    Text("Task description : \(taskx.description)")
//                                                    Text("Task progress : \(taskx.progress)")
//                                                    Text("Task target : \(taskx.target)")
//                                                    Text("Task type : \(taskx.type)")
//                                                    Spacer().frame(height: 32)
//                                                    var taskData: TaskData? = getUserTask(documentId: taskx.documentId)
//                                                    if(taskData != nil){
//                                                        Text("document_id : \(taskData!.documentId)")
//                                                        Text("progress : \(taskData!.progress)")
//                                                        Text("target : \(taskData!.target)")
//                                                        Text("image : \(taskData!.image)")
//                                                    } else {
//                                                        Button{
//
//                                                        } label: {
//                                                            Text("start task")
//                                                                .padding(.vertical, 16)
//                                                                .frame(maxWidth: .infinity)
//                                                                .foregroundColor(.white)
//                                                                .background(.blue)
//                                                        }
//                                                    }
//
//                                                }
//                                                .background(.blue.opacity(0.2))
//                                            }
//                                        }
//                                    }
//                                    .background(.gray.opacity(0.3))
//                                    }
//
//                                }
//                            }
//                            Divider()
//                        }
//                    }
//                    .padding(24)
//                case .empty:
//                    Text("Empty")
//                }
//            }
//        }
//    }
//}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(islands: [mockupIsland1])
//    }
//}


enum APIError: Error, CustomStringConvertible {
    case known(msg: String)
    case unknown
    
    var localizedDescription: String {
        // user feedback
        switch self {
        case .unknown:
            return "Sorry, something went wrong."
        case .known(let msg):
            return "Error : \(msg)"
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown:
            return "Sorry, something went wrong."
        case .known(let msg):
            return "Error : \(msg)"
        }
    }
    
}

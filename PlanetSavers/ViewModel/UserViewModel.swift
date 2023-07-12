//
//  UserViewModel.swift
//  Planty
//
//  Created by Muhammad Rezky on 08/07/23.
//

import SwiftUI
import Combine
import Firebase

class UserViewModel: ObservableObject {
    @Published var islands: [Island] = []
    @Published var taskDatas: [TaskData] = []
    @Published var state: ViewState = ViewState.empty
    @Published var selectedGroupTask: GroupTask? = nil

    init() {
        Task{
            await loadData()
        }
    }
    
    func getUserTask(documentId: String) -> TaskData? {
        return taskDatas.first { $0.documentId == documentId }
        
    }
    
    func fetchUserTask(completion: @escaping () -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("task")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching user tasks: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                print("update")
                
                var updatedTaskDatas: [TaskData] = []
                
                for document in documents {
                    let snapshot = document.data()
                    let taskData = TaskData(dictionary: snapshot)
                    updatedTaskDatas.append(taskData)
                }
                
                self.taskDatas = updatedTaskDatas
                completion()
            }
    }
    

    
    func fetchData() async -> [Island] {
        var islandDatas: [Island] = []
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return []}
        do{
            let snapshot = try await FirebaseManager.shared.firestore.collection("users").document(uid).getDocument()
            if let data = snapshot.data() {
                if let islands = data["island"] as? [DocumentReference]{
                    for island in islands {
                        islandDatas.append(await fetchIsland(island))
                    }
                }
            }
            return islandDatas
        } catch {
            print(error)
        }
        return islandDatas
    }
    
    func fetchIsland(_ ref: DocumentReference) async -> Island{
        do {
            var island: Island = Island()
            let snapshot = try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
            if let data = snapshot.data() {
                island.documentId = data["document_id"] as! String
                if let groupTasks = data["group_tasks"] as? [DocumentReference]{
                    for group in groupTasks {
                        island.groupTasks.append(await fetchGroupTask(group))
                    }
                }
            }
            return island
        } catch {
            print(error)
            return Island()
        }
    }
    
    func fetchGroupTask(_ ref: DocumentReference) async  -> GroupTask{
        do {
            var groupTask: GroupTask = GroupTask()
            let snapshot =  try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
            
            if let data = snapshot.data() {
                groupTask = GroupTask(dictionary: data)
                if let tasks = data["tasks"] as? [DocumentReference]{
                    for task in tasks {
                        groupTask.tasks.append(await fetchTask(task))
                    }
                }
            }
            return groupTask
        } catch {
            print(error)
            return GroupTask()
        }
    }
    
    func fetchTask(_ ref: DocumentReference) async -> Taskx {
        do{
            let snapshot = try await FirebaseManager.shared.firestore.document(ref.path).getDocument()
            return Taskx(dictionary: snapshot.data()!)
        } catch {
            print(error)
            return Taskx()
        }
    }
    
    
    
    func loadData() async {
        state = .loading
        let result = await fetchData()
        print(result)
        DispatchQueue.main.async {
            self.islands = result
            
        }
        fetchUserTask(){
            DispatchQueue.main.async {
                self.state = .loaded
            }
            print("completeeee")
       }
    }
}

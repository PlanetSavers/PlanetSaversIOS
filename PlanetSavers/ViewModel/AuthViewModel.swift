//
//  AuthenticationViewModel.swift
//  Planty
//
//  Created by Muhammad Rezky on 10/07/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

class AuthViewModel: ObservableObject {
    @Published var state: ViewState = .empty
    @Published var isError: Bool = false
    @Published var errorMsg = ""
    @Published var isLogin = true
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var password: String = ""
    @Published var repassword: String = ""
    @Published var isAuthenticated: Bool = false
    
    
    func isUserAuthenticated(){
        let uid = FirebaseManager.shared.auth.currentUser?.uid
        print("uid \(uid)")
        if(uid == nil){
            return
        }
        DispatchQueue.main.async {
            self.isAuthenticated = true
            print(self.isAuthenticated)
        }
        print("---")
        
    }
    
    
    func initIsland() {
        let firestore = FirebaseManager.shared.firestore
        let islandCollectionReference = firestore.collection("island")
        // init island
        for island in mockup {
            let grouptaskReferences: [DocumentReference] = initGroupTask(island: island)
            let islandData: [String: Any] = [
                "document_id": island.documentId,
                "group_tasks": grouptaskReferences,
            ]
            islandCollectionReference.document(island.documentId).setData(islandData)
        }
    }
    
    func initGroupTask(island: Island) -> [DocumentReference]{
        let firestore = FirebaseManager.shared.firestore
        let groupTaskCollectionReference = firestore.collection("group_task")
        
        var groupTaskReferences: [DocumentReference] = []
        
        for groupTask in island.groupTasks {
            let taskReferences: [DocumentReference] = initTask(groupTask: groupTask)
            
            let groupTaskData: [String: Any] = [
                "document_id": groupTask.documentId,
                "title": groupTask.title,
                "description": groupTask.description,
                "image": groupTask.image,
                "tasks": taskReferences
            ]
            groupTaskCollectionReference.document(groupTask.documentId).setData(groupTaskData)
            
            let reference = groupTaskCollectionReference.document(groupTask.documentId)
            groupTaskReferences.append(reference)
        }
        
        return groupTaskReferences
    }
    
    func initTask(groupTask: GroupTask) -> [DocumentReference]{
        let firestore = FirebaseManager.shared.firestore
        let taskCollectionReference = firestore.collection("task")
        
        var taskReferences: [DocumentReference] = []
        for task in groupTask.tasks {
            let taskData: [String: Any] = [
                "document_id": task.documentId,
                "title": task.title,
                "description": task.description,
                "type" : task.type,
                "progress": task.progress,
                "target": task.target
            ]
            taskCollectionReference.document(task.documentId).setData(taskData)
            let reference = taskCollectionReference.document(task.documentId)
            
            taskReferences.append(reference)
            
        }
        return taskReferences
    }
    

    
    func initUserData() async {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let usersCollectionReference = FirebaseManager.shared.firestore.collection("users")
        do {
            try await usersCollectionReference.document(uid).setData([
                "document_id" : uid,
                "fullname" : fullname,
                "email" : email,
                "island" : [
                    FirebaseManager.shared.firestore.collection("island").document("island1")
                ]
            ])
        } catch {
            print(error)
        }
        
    }
    
    
    func registerAccount() async {
        if(repassword != password){
            DispatchQueue.main.async {
                self.errorMsg = "Password and RePassword Should Same"
                self.isError = true
            }
            return
        }
        if(fullname == ""){
            DispatchQueue.main.async {
                self.errorMsg = "Name should not empty"
                self.isError = true
            }
            return
        }
        do {
            let snapshot =   try await FirebaseManager.shared.auth.createUser(withEmail: email, password: password)
            print("Success : \(String(describing: snapshot.user.email))")
            await self.initUserData()
            self.isUserAuthenticated()
        } catch {
            print("Error : \(error)")
            DispatchQueue.main.async {
                self.errorMsg = error.localizedDescription
                self.isError = true
            }
        }
        
    }
    
    func loginAccount() async {
        do {
            let snapshot =   try await FirebaseManager.shared.auth.signIn(withEmail: email, password: password)
            print("Success : \(String(describing: snapshot.user.email))")
            self.isUserAuthenticated()
        } catch {
            print("Error : \(error)")
            DispatchQueue.main.async {
                self.errorMsg = error.localizedDescription
                self.isError = true
            }
        }
    }
    
    func logout(){
       try? FirebaseManager.shared.auth.signOut()
    }
    
}

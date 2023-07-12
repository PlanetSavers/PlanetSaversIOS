//
//  ContentView.swift
//  Planty
//
//  Created by Muhammad Rezky on 28/06/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI
import AVKit

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
    
}

struct TaskData: Identifiable, Hashable {
    let id = UUID().uuidString 
    var documentId: String = ""
    var progress: Int = 0
    var target: Int = 1
    var image: String = ""
    
    init(){}
    
    init(documentId: String, progress: Int, target: Int, image: String) {
        self.documentId = documentId
        self.progress = progress
        self.target = target
        self.image = image
    }
    
    init(dictionary: [String: Any]) {
        self.documentId = dictionary["document_id"] as? String ?? ""
        self.progress = dictionary["progress"] as? Int ?? -1
        self.target = dictionary["target"] as? Int ?? 0
        self.image = dictionary["image"] as? String ?? ""
    }
}

struct Island: Identifiable, Hashable  {
    var documentId: String = ""
    var groupTasks: [GroupTask] = []
    let id = UUID().uuidString
    
    
    init() {
    }
    
    init(documentId: String, groupTasks: [GroupTask]) {
        self.documentId = documentId
        self.groupTasks = groupTasks
    }
    
    init(dictionary: [String: Any]) {
        self.documentId = dictionary["documentId"] as? String ?? ""
//        self.groupTasks = (dictionary["groupTasks"] as? [[String: Any]] ?? []).compactMap { GroupTask(dictionary: $0) }
    }
}

struct GroupTask: Identifiable, Hashable  {
    // not implemented
    var title: String = ""
    var description: String = ""
    var image: String = ""
    //
    var documentId: String = ""
    var tasks: [Taskx] = []
    let id = UUID().uuidString
    
    
    init() {
    }
    
    init(documentId: String, title: String ,description: String, image: String, tasks: [Taskx]) {
        self.title = title
        self.description = description
        self.documentId = documentId
        self.tasks = tasks
    }
    
    init(dictionary: [String: Any]) {
        self.documentId = dictionary["document_id"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
//        self.tasks = (dictionary["tasks"] as? [[String: Any]] ?? []).compactMap { Taskx(dictionary: $0) }
    }
}

struct Taskx: Identifiable, Hashable  {
    // --- not implemented
    var title: String = ""
    var subtitle: String = ""
    var progress: Int = 0
    var target: Int = 1
    //
    var documentId: String = ""
    var description: String = ""
    var type: String = ""
    let id = UUID().uuidString
    
    init() {
    }
    
    init(documentId: String,title: String, subtitle: String, description: String, type: String, progress: Int, target: Int) {
        self.documentId = documentId
        self.description = description
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.progress = progress
        self.target = target
    }
    
    init(dictionary: [String: Any]) {
        self.documentId = dictionary["document_id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.subtitle = dictionary["subtitle"] as? String ?? ""
        self.progress = dictionary["progress"] as? Int ?? 0
        self.target = dictionary["target"] as? Int ?? 1
        self.description = dictionary["description"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
    }
}


let mockup: [Island] = [islandMock]
//
//let mockupIsland1: Island = Island(
//    documentId: "island1",
//    groupTasks: [
//        GroupTask(
//            documentId: "grouptask1",
//            title: "Group Task 1",
//            description:  "ini cuman test task",
//            image: "",
//            tasks: [
//                Taskx(
//                    documentId: "task1",
//                    title: "Bersepeda",
//                    description: "test default untuk track bersepeda",
//                    type: "cycle",
//                    progress: 0,
//                    target: 1000
//                ),
//                Taskx(
//                    documentId: "task2",
//                    title: "Berjalan",
//                    description: "test default untuk track berjalan",
//                    type: "walk",
//                    progress: 0,
//                    target: 500
//                ),
//                Taskx(
//                    documentId: "task3",
//                    title: "Berlari",
//                    description: "test default untuk upload berlari",
//                    type: "run",
//                    progress: 0,
//                    target: 100
//                ),
//            ]
//        ),
//        GroupTask(
//            documentId: "grouptask2",
//            title: "Group Task 2",
//            description:  "ini cuman test task",
//            image: "",
//            tasks: [
//                Taskx(
//                    documentId: "task4",
//                    title: "upload photo",
//                    description: "test default untuk upload photo",
//                    type: "photo",
//                    progress: 0,
//                    target: 1
//                ),
//                Taskx(
//                    documentId: "task5",
//                    title: "upload video",
//                    description: "test default untuk upload video",
//                    type: "video",
//                    progress: 0,
//                    target: 1
//                )
//            ]
//        ),
//
//    ]
//)



struct ContentView: View {
    @State var email: String = ""
    @State var fullname: String = ""
    @State var password: String = ""

    
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
                "subtitle": task.subtitle,
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
    
    func registerAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){result, error in
            if let error = error {
                print("Failed to create user : \(error)")
                return
            }
            initUserData()
            print("Successfully create user : \(result?.user.uid)")
            
        }
    }
    
    func initUserData(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let usersCollectionReference = FirebaseManager.shared.firestore.collection("users")
        usersCollectionReference.document(uid).setData([
            "document_id" : uid,
            "fullname" : fullname,
            "email" : email,
            "island" : [
                FirebaseManager.shared.firestore.collection("island").document("island1")
            ]
        ])
        
    }
    func loginAccount() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("Failed to login : \(error)")
                return
            }
            print("Successfully login. user : \(result?.user.uid)")
        }
    }
    
    func logout(){
       try? FirebaseManager.shared.auth.signOut()
    }
    
    
    
    
    var body: some View {
        VStack (spacing: 24){
            
            Button{
                initIsland()
            } label: {
                Text("Init Island")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
            }
            TextField("Full Name", text: $fullname)
            TextField("Email", text: $email)
            TextField("Password", text: $password)
            Button{
                registerAccount()
            } label: {
                Text("Register")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
            }
            Button{
                loginAccount()
            } label: {
                Text("Login")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
            }
            Button{
                logout()
            } label: {
                Text("Logout")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
            }
            Button{
                print(
                    FirebaseManager.shared.auth.currentUser?.email)
            } label: {
                Text("check auth")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
            }
        } 
        
        .padding(24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

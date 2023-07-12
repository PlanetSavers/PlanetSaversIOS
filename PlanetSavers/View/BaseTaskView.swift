//
//  BaseTaskView.swift
//  Planty
//
//  Created by Muhammad Rezky on 08/07/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

struct BaseTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var task: Taskx
    @Binding var data: TaskData?
    
    @State private var shouldShowImagePicker = false
    @State var image: UIImage? = nil
    
    
    private func uploadImageToStorage()  {
        
        if(image == nil){
            return
        }
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return  }
        let ref = FirebaseManager.shared.storage.reference(withPath: "\(uid)/\(task.documentId)/")
        
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return  }
        
        
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print("Failed to push image to Storage: \(err)")
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                
                guard let url = url else {return}
                print("Successfully stored image with url: \(url.absoluteString ?? "")")
                updateUserTaskData(imageURL: url)
            }
        }
        
    }
    
    private func updateUserTaskData(imageURL: URL)  {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("task")
            .document(data!.documentId)
            .updateData(
                [
                    "image": imageURL.absoluteString,
                    "progress": 1
                ]){error in
                    print(error)
                    goToCongratsPage.toggle()
                    // update
                    
                }
    }
    
    private func finishTask(){
        goToCongratsPage.toggle()
    }
    
    @State var goToCongratsPage = false
    @State var showImpact: Bool = true
    
    
    
    
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
        else {
            VStack(spacing: 0){
                NavigationLink(destination: CongratulationView()
                               
                    .navigationBarBackButtonHidden(true), isActive: $goToCongratsPage){
                    EmptyView()
                        
                        .navigationBarBackButtonHidden(true)
                }
                ZStack(alignment: .top){
                    Image("base-background")
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
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Title")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                            Text("Lorem ipsum dolor sit amet consectetur. Tellus est ante sagittis venenatis sed nunc.")
                                .lineSpacing(4)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.22))
                            
                            
                        }
                        .padding(16)
                        .frame(width: 358, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                        HStack{
                            
                            VStack(alignment: .center, spacing: 16) {
                                Image(systemName: "photo")
                                    .foregroundColor(.black)
                                Text("Tambah foto")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, maxHeight: 156, alignment: .center)
                            .background(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color("green600"), style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                            )
                            .onTapGesture {
                                shouldShowImagePicker.toggle()
                            }
                            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                                ImagePicker(image: $image)
                                    .ignoresSafeArea()
                            }
                            
                            
                            
                            
                            VStack(alignment: .center, spacing: 16) {
                                Image(systemName: "video")
                                Text("Tambah video")
                                
                                
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, maxHeight: 156, alignment: .center)
                            .background(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color("green600"), style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                            )
                        }
                        .padding(.horizontal, 16)
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Preview")
                            
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                            if(data!.image != "" && image == nil){
                                
                                AsyncImage(url: URL(string: data!.image)){ phase in
                                    switch phase {
                                    case .empty:
                                        // Placeholder or loading view
                                        ProgressView()
                                    case .success(let imagex):
                                        // Display the image
                                        imagex
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                }
                                    
                        
                            }
                        }
                        .padding(16)
                        .frame(width: 358, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                    }
                    
                    
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - 100)
                    .background(.red)
                VStack(alignment: .center){
                    Button{
                        uploadImageToStorage()
                        
                    } label: {
                        Text("Upload")
                        
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                            .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                            .cornerRadius(99)
                    }
                    .padding(16)
                    
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
}
//
//struct BaseTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseTaskView(
//            task: Taskx(
//                documentId: "base",
//                title: "Bersepeda",
//                description: "Deskripsi",
//                type: "base",
//                progress: 0,
//                target: 100
//            ),
//            data: .constant(TaskData(
//                documentId: "cycl1",
//                progress: 0,
//                target: 100,
//                image: ""
//            ))
//        )
//    }
//}

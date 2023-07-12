//
//  AuthenticationView.swift
//  Planty
//
//  Created by Muhammad Rezky on 10/07/23.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State var isLogin = true
    @State var isAuthenticated: Bool
    
    init() {
        if let uid = FirebaseManager.shared.auth.currentUser?.uid {
            self.isAuthenticated = true
        }
        else {
             self.isAuthenticated = false
        }
        
    }
    var body: some View {
            if(isAuthenticated){
                HomeView()
                    .navigationBarHidden(true)
                    .environmentObject(UserViewModel())
            } else {
                VStack{
                    if(isLogin){
                        LoginView(
                            authViewModel: authViewModel
                        ).onChange(of: authViewModel.isLogin){_ in
                            isLogin = authViewModel.isLogin
                        }
                        .onChange(of: authViewModel.isAuthenticated){_ in
                            isAuthenticated = authViewModel.isAuthenticated
                        }
                    } else {
                        RegisterView(
                            authViewModel: authViewModel
                        ).onChange(of: authViewModel.isLogin){_ in
                            isLogin = authViewModel.isLogin
                        }
                        .onChange(of: authViewModel.isAuthenticated){_ in
                            isAuthenticated = authViewModel.isAuthenticated
                        }
                    }
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            }
        
    }
}

//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticationView()
//    }
//}

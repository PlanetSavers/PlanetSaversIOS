//
//  RegisterView.swift
//  Planty
//
//  Created by Muhammad Rezky on 09/07/23.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("Bergabung dengan PlanetSavers")
                .font(.system(size: 28, weight: .medium, design: .rounded))
                .padding(.bottom, 8)
            Text("Mulailah aksi nyatamu")
                .lineSpacing(4)
                .font(.system(size: 17,weight: .regular, design: .rounded))
                .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
            
            //            TextField("Full Name", text: $fullname)
            VStack(spacing: 24){
                VStack(spacing: 0){
                    TextField("Nama", text: $authViewModel.fullname)
                        .disableAutocorrection(true)
                        .frame(height: 48)
                    
                    Divider()
                }
                VStack(spacing: 0){
                    TextField("Email", text: $authViewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .frame(height: 48)
                    
                    Divider()
                }
                
                VStack(spacing: 0){
                    SecureField("Password", text: $authViewModel.password)
                        .frame(height: 48)
                    
                    Divider()
                }
                
                VStack(spacing: 0){
                    SecureField("Re Password", text: $authViewModel.repassword)
                        .frame(height: 48)
                    
                    Divider()
                }
            }
            .padding(.top, 60)
            
            Button{
                Task{
                    await  authViewModel.registerAccount()
                }
            } label: {
                Text("Daftar")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                    .cornerRadius(99)
            }
            .alert("\(authViewModel.errorMsg)", isPresented: $authViewModel.isError) {
                Button("OK", role: .cancel) { }
            }
            .padding(.top, 80)
            Button{
                print("to login")
                authViewModel.isLogin = true
                
            } label: {
                HStack(alignment: .center, spacing: 0){
                    Spacer()
                    Text("Sudah punya akun?")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                    Text(" Masuk")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("green600"))
                    Spacer()
                }
                .frame(alignment: .center)
                
            }
            .padding(.top, 24)
            Spacer()
            
        }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .ignoresSafeArea()
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(
                
                VStack{
                    Image("register-background")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
                    .ignoresSafeArea()
            )
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}

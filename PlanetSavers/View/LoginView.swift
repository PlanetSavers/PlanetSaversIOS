//
//  LoginView.swift
//  Planty
//
//  Created by Muhammad Rezky on 09/07/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("Selamat Datang Kembali!")
                .font(.system(size: 28, weight: .medium, design: .rounded))
                .padding(.bottom, 8)
            Text("Lanjutkan aksi nyatamu dalam mengatasi perubahan iklim")
                .lineSpacing(4)
                .font(.system(size: 17,weight: .regular, design: .rounded))
                .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
            
            //            TextField("Full Name", text: $fullname)
            VStack(spacing: 24){
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
            }
            .padding(.top, 60)
            HStack{
                Spacer()
                Button{} label: {
                    Text("Lupa kata sandi?")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("green600"))
                }
            }
            .padding(.top, 12)
            
            Button{
                Task{
                    await authViewModel.loginAccount()
                }
            } label: {
                Text("Masuk")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                    .cornerRadius(99)
            }
            .padding(.top, 80)
            .alert("\(authViewModel.errorMsg)", isPresented: $authViewModel.isError) {
                        Button("OK", role: .cancel) { }
            }
            Button{
                print("to regis")
                authViewModel.isLogin = false
            } label: {
                HStack(alignment: .center, spacing: 0){
                    Spacer()
                    Text("Belum punya akun?")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.4))
                    Text(" Daftar")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("green600"))
                    Spacer()
                }
                .frame(alignment: .center)
                
            }
            .padding(.top, 24)
            Spacer()
            
            
        }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(
                
                VStack{
                    Image("login-background")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Image("login-background-2")
                        .resizable()
                        .scaledToFit()
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                    .ignoresSafeArea()
            )
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(authViewModel: AuthViewModel())
//    }
//}

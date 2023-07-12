//
//  OnboardingView.swift
//  Planty
//
//  Created by Muhammad Rezky on 11/07/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var index = 0
    @State var navigateToAuth = false
    @State var data: [(String, String)] = [
        (
            "Bersama-sama kita\ndapat membuat\nperbedaan!",
            "onboarding-1"
        ),
        (
            "Setiap langkah kecil\nberarti banyak!",
            "onboarding-2"
        ),
        (
            "Satukan langkah\nuntuk masa depan\nyang lebih baik!",
            "onboarding-3"
        ),
    ]
    var body: some View {
            VStack{
                HStack{
                    Rectangle()
                        .frame(width: .infinity, height: 4)
                        .foregroundColor(
                            index >= 0 ? Color("green600") : Color.white
                        )
                    Rectangle()
                        .frame(width: .infinity, height: 4)
                        .foregroundColor(
                        index >= 1 ? Color("green600") : Color.white
                        )
                    
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(
                    index >= 2 ? Color("green600") : Color.white
                    )
                }
                .padding(.horizontal, 16)
                Spacer()
                Spacer()
                Image(data[index].1)
                Spacer()
                HStack{
                    Text(data[index].0)
                        .lineSpacing(8)
                        .font(.system(size: 34, weight: .semibold, design: .rounded)).multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 16)
                NavigationLink( destination: AuthenticationView(), isActive: $navigateToAuth){
                    EmptyView()
                }
                Button{
                    if !(index > 1 ){
                        index += 1
                    } else {
                        navigateToAuth.toggle()
                    }
                } label: {
                    Text("Selanjutnya")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                        .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                        .cornerRadius(99)
                }
                .padding(.top, 82)
                .padding(.horizontal, 16)
            }
            .frame(alignment: .bottom)
            .background(
                VStack{
                    Image("onboarding-background")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    Spacer()
                }
                    
            )
        }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

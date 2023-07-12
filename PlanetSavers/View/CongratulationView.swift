//
//  CongratulationView.swift
//  Planty
//
//  Created by Muhammad Rezky on 12/07/23.
//

import SwiftUI

struct CongratulationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 0){
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
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 8)
            Text("Selamat!")
                .font(.system(size: 34, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text("Langkah kecilmu memberikan perbedaan nyata dalam meminimalisir perubahan iklim")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.4, green: 0.44, blue: 0.52))
                .lineSpacing(4)
            Spacer()
            Image("congrats-plant")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 32)
            Spacer()
            Spacer()
            Button{
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Selanjutnya")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                    .cornerRadius(99)
            }
        }
        .padding(.horizontal, 16)
        .background(
            VStack{
                Image("congrats-background")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                Spacer()
            }
        )
    }
}

struct CongratulationView_Previews: PreviewProvider {
    static var previews: some View {
        CongratulationView()
    }
}

//
//  WalkTaskView.swift
//  Planty
//
//  Created by Muhammad Rezky on 07/07/23.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding  var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color("green100"),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color("green600"),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            // 1
                .animation(.easeOut, value: progress)
            
        }
    }
}

struct WalkTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {

            VStack(spacing: 0){
                ZStack(alignment: .top){
                    Image("walk-background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    VStack{
                        HStack(alignment: .top){
                            VStack(alignment: .leading, spacing: 4){
                                Text("Target Langkah")
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .frame(alignment: .leading)
                                Text("1500")
                                
                                .font(.system(size: 40, weight: .semibold, design: .rounded))
                            }
                            Spacer()
                            Button{
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            }
                        }
                        .padding(16)
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(20)
                        Spacer()
                        ZStack(alignment: .center){
                            Rectangle()
                                .background(.white)
                                .foregroundColor(.white)
                                .frame(width: 255, height: 255)
                                .cornerRadius(1000)
                            CircularProgressView(progress: .constant(0.3))
                                .frame(width: 200, height: 200)
                            VStack{
                                Text("Langkah")
                                
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                Text("460")
                                
                                .font(.system(size: 35, weight: .semibold, design: .rounded))
                                    .kerning(0.46072)
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    .padding(16)
                    
                    
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - 100)
                    .background(.red)
                VStack(alignment: .center){
                    Button{
                    } label: {
                        Text("Mulai Berjalan")
                        
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
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            .navigationBarHidden(true)

    }
}

//struct WalkTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        WalkTaskView()
//    }
//}

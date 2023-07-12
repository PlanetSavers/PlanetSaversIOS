//
//  TestWalkView.swift
//  Planty
//
//  Created by Muhammad Rezky on 07/07/23.
//


import SwiftUI
import HealthKit

struct Steps: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct TestWalkView: View {
    var healthStore: HealthStore?
    
    @State var steps: [Steps] = [Steps]()
    @State var goals: Int = 0
    @State var isPresented: Bool = false
    @State var isModal: Bool = false
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    init() {
        healthStore = HealthStore()
    }

    var body: some View {
        NavigationStack{
            VStack {
                VStack{
                    Text("HealthKit: Steps")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding()
                    
                    Button("Add Weekly Goal") {
                        self.isPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.blue)
                }
                .sheet(isPresented: $isPresented){
                    AddGoalView(goals: self.$goals, isPresented: self.$isPresented)
                }
                
                DialView(goal: self.goals, steps: totalSteps)
                    .padding(10)
                
//                VStack{
//                    Button("Weekly summary") {
//                        self.isModal = true
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .controlSize(.large)
//                    .tint(.blueColor)
//                }
//                .sheet(isPresented: $isModal){
//                    GraphView(isModal: self.$isModal, steps: steps)
//                }
            }
            .padding()
            .background(Color.gray)
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Steps(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
}

//struct TestWalkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DialView(goal: 2000, steps: 200)
//    }
//}



struct AddGoalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var goals: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Weekly Goal Steps").font(.title2).foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    HStack {
                        TextField("Search...", text: Binding(get: {String(goals)}, set: {goals = Int($0) ?? 0 }))
                    }
                    .keyboardType(.decimalPad)
                    
                    Button("Save Goal"){
                        self.isPresented = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color.blue)
                }.padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DialView: View {

    let goal: Int
    let steps: Int

    var body: some View {
        ZStack {
            CircleView()
            
            ZStack {
                CircleView()

                Circle().stroke(style: StrokeStyle(lineWidth: 12))
                    .padding(20)
                    .foregroundColor(.gray)

                Circle()
                    .trim(from: 0, to: (CGFloat(steps) / CGFloat(goal)))
                    .scale(x: -1)
                    .rotation(.degrees(90))
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .padding(20)
                    .foregroundColor(.blue)

                VStack {
                    Text("Weekly Goal: \(goal)")
                        .font(.title2)
                        .padding(.bottom)
                    Text("This Week steps:")

                    Text("\(steps)")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        .foregroundColor(.accentColor)
    }

}


import Foundation
import SwiftUI

struct CircleView: View {

    private let shadowOffset: CGFloat = 8
    private let shadowRadius: CGFloat = 3
    private let shadowColor: Color = .gray
    private let highlightColor: Color = .white

    var body: some View {
        Circle().fill(Color.gray)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset, y: shadowOffset)
            .shadow(color: highlightColor, radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
    }
}



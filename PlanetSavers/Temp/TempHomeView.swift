//
//  TempHomeView.swift
//  Planty
//
//  Created by Muhammad Rezky on 08/07/23.
//

import SwiftUI

var userTaskDataMock: [TaskData] = [
    TaskData(documentId: "task1", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task2", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task3", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task4", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task5", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task6", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task7", progress: 0, target: 1, image: ""),
    TaskData(documentId: "task8", progress: 0, target: 1, image: "")
]

var islandMock: Island = Island(
    documentId: "island1",
    groupTasks: [
        GroupTask(
            documentId: "grouptask1",
            title: "Mengurangi Polusi",
            description: "Jalan-jalan di Indonesia penuh dengan kendaraan menggunakan solar atau bensin. Untuk mengurangi emisi gas rumah kaca dan meningkatkan kesehatan, berjalan kaki atau naik sepeda daripada mengemudi dapat menjadi pilihan dan dapat mengurangi jejak karbon Anda hingga 2 ton CO2e per tahun.",
            image: "",
            tasks: [
                Taskx(
                    documentId: "task1",
                    title: "Bersepeda ke Tempat Tujuan",
                    subtitle: "Bersepeda selama 2 Jam",
                    description: "Dengan bersepeda, kita bisa melawan perubahan iklim dengan cara yang menyenangkan. Selain mengurangi emisi gas rumah kaca, bersepeda juga membantu membersihkan udara dari polusi dan mengurangi ketergantungan pada bahan bakar fosil. Bonusnya, kita bisa menghindari kemacetan dan sekaligus menjaga kesehatan dan kebugaran kita. Ayo, bergabunglah dalam pergerakan bersepeda untuk menjaga planet ini tetap hijau dan memberikan kontribusi positif bagi masa depan kita!",
                    type: "cycle",
                    progress: 0,
                    target: 7200
                ),
                Taskx(
                    documentId: "task2",
                    title: "Berjalan ke Tempat Tujuan",
                    subtitle: "Berjalan sebanyak 5000 langkah",
                    description: "Dengan berjalan kaki, kita bisa mengurangi emisi gas rumah kaca dan menjaga kesehatan kita. Nikmati udara segar, jelajahi lingkungan sekitar, dan sambil menyelamatkan planet ini. Ayo, bergabunglah dalam gerakan berjalan kaki untuk mengurangi dampak perubahan iklim dan menciptakan masa depan yang lebih hijau!",
                    type: "walk",
                    progress: 0,
                    target: 5000
                ),
                Taskx(
                    documentId: "task3",
                    title: "Menggunakan Transportasi Umum ke Tempat Tujuan",
                    subtitle: "Menggunakan Transportasi Umum Sekali",
                    description: "Dengan memilih menggunakan transportasi umum, kita dapat mengurangi emisi gas rumah kaca, kemacetan, dan tekanan pada sumber daya alam. Naik kereta atau bus adalah cara yang ramah lingkungan untuk berpergian jarak jauh, sambil mengurangi jejak karbon kita. Selain itu, dengan menggunakan transportasi umum, kita dapat mengurangi polusi udara dan membagi kendaraan dengan orang lain. Ayo, bergabunglah dalam gerakan transportasi umum dan berkontribusilah dalam menciptakan masa depan yang lebih hijau dan berkelanjutan!",
                    type: "base",
                    progress: 0,
                    target: 1
                )
            ]
        ),
        GroupTask(
            documentId: "grouptask2",
            title: "Penghijauan",
            description: "Sedikitnya lahan hijau memiliki dampak serius terhadap perubahan iklim, dampaknya dapat menghilangkan sumber karbon yang penting dalam menyerap gas rumah kaca, seperti karbon dioksida. Mulailah dengan menjaga bumi tetap hijau. Satu langkah kecil dapat memberikan dampak besar. Bersama-sama menanam pohon atau ikut serta dalam program penanaman pohon. Dengan setiap pohon yang kita tanam, kita memberikan harapan baru bagi manusia, hewan, dan ekosistem.",
            image: "",
            tasks: [
                Taskx(
                    documentId: "task4",
                    title: "Menanam Pohon",
                    subtitle: "Menanam 1 Pohon",
                    description: "Dengan menanam pohon, kita bisa memberikan dampak positif yang besar pada perubahan iklim dan keberlanjutan. Pohon membantu menyerap karbon dioksida, memperbaiki kualitas udara, dan menciptakan habitat bagi berbagai makhluk hidup. Ayo, bergabunglah dalam aksi menanam pohon, baik di lingkungan sekitar kita maupun melalui program penanaman pohon. Jadilah pahlawan hijau dan bantu menjaga keindahan dan keseimbangan alam kita!",
                    type: "base",
                    progress: 0,
                    target: 1
                ),
                Taskx(
                    documentId: "task5",
                    title: "Memilah Sampah Berdasarkan Jenis",
                    subtitle: "Melakukan pemisahan sampah berdasarkan jenis",
                    description: "Dengan memilah sampah sesuai dengan jenisnya, kita dapat mengurangi jumlah sampah yang akhirnya masuk ke tempat pembuangan akhir. Pisahkan sampah organik, plastik, kertas, logam, dan kaca. Dengan cara ini, kita bisa mendaur ulang dan memanfaatkan kembali bahan-bahan yang masih dapat digunakan. Daur ulang membantu mengurangi penggunaan sumber daya alam, mengurangi polusi, dan mengurangi emisi gas rumah kaca yang dihasilkan dari pembuangan sampah. Ayo, jadilah agen daur ulang dan berkontribusilah dalam menciptakan lingkungan yang lebih bersih dan berkelanjutan!",
                    type: "base",
                    progress: 0,
                    target: 1
                ),
            ]
        ),
        GroupTask(
            documentId: "grouptask3",
            title: "Membersihkan Sampah",
            description: "Manusia, hewan, dan tumbuhan semuanya menderita akibat lahan dan air yang terkontaminasi oleh sampah yang dibuang secara tidak benar. Gunakan apa yang dibutuhkan, dan ketika harus membuang sesuatu, buanglah dengan benar. Ikut serta dalam kegiatan membersihkan taman, sungai, pantai, dan sekitarnya. Setiap tahun, orang-orang membuang 2 miliar ton sampah. Sekitar sepertiga dari jumlah tersebut menyebabkan kerusakan lingkungan, mulai dari mencemari pasokan air hingga meracuni tanah.",
            image: "",
            tasks: [
                Taskx(
                    documentId: "task6",
                    title: "Membersihkan Lingkungan Rumah",
                    subtitle: "Membersihkan lingkungan rumahmu",
                    description: "Dengan menjaga kebersihan lingkungan rumah, kita dapat mengurangi dampak negatif terhadap perubahan iklim. Misalnya, dengan menggunakan energi yang efisien dan mengurangi pemborosan, kita dapat mengurangi emisi gas rumah kaca yang berasal dari sumber energi. Selain itu, dengan memilah dan mendaur ulang sampah di rumah, kita mengurangi jumlah sampah yang akhirnya akan membusuk dan menghasilkan gas rumah kaca, seperti metana. Jadi, dengan membersihkan lingkungan rumah secara bertanggung jawab, kita turut berperan dalam memitigasi perubahan iklim dan menjaga keberlanjutan lingkungan kita.",
                    type: "base",
                    progress: 0,
                    target: 1
                ),
                Taskx(
                    documentId: "task7",
                    title: "Membersihkan Lingkungan",
                    subtitle: "Membersihkan lingkungan sekitar rumahmu",
                    description: "Dengan membersihkan lingkungan sekitar kita, kita dapat mengurangi polusi dan memberikan kontribusi nyata terhadap kebersihan planet ini. Ikut serta dalam kegiatan pembersihan taman, sungai, pantai, atau area lainnya. Bersama-sama, kita bisa menciptakan lingkungan yang lebih bersih, sehat, dan indah. Ayo, bergabunglah dalam gerakan membersihkan lingkungan dan menjadi pahlawan bagi bumi kita!",
                    type: "base",
                    progress: 0,
                    target: 1
                ),
                Taskx(
                    documentId: "task8",
                    title: "Memilah Sampah Berdasarkan Jenis",
                    subtitle: "Memilah sampah berdasarkan jenisnya",
                    description: "Dengan memilah sampah sesuai dengan jenisnya, kita dapat mengurangi jumlah sampah yang akhirnya masuk ke tempat pembuangan akhir. Pisahkan sampah organik, plastik, kertas, logam, dan kaca. Dengan cara ini, kita bisa mendaur ulang dan memanfaatkan kembali bahan-bahan yang masih dapat digunakan. Daur ulang membantu mengurangi penggunaan sumber daya alam, mengurangi polusi, dan mengurangi emisi gas rumah kaca yang dihasilkan dari pembuangan sampah. Ayo, jadilah agen daur ulang dan berkontribusilah dalam menciptakan lingkungan yang lebih bersih dan berkelanjutan!",
                    type: "base",
                    progress: 0,
                    target: 1
                ),
            ]
        )
    ]
)

struct TempHomeView: View {
    var island: Island = islandMock
    func getTaskx(_ documentId: String) -> Taskx? {
        return island.groupTasks
            .flatMap { $0.tasks }
            .first { $0.documentId == documentId }
    }
    
    func isCompleted(_ objectName: String) -> Bool{
        switch objectName{
        case "landscape-1":
            return checkCompletion("task5")
        case "landscape-2":
            return checkCompletion("task5")
        case "cars-object":
            return checkCompletion("task3")
        case "bus-object":
            return checkCompletion("task3")
        case "trash-object":
            return checkCompletion("task6")
        case "river-bad-object":
            return checkCompletion("task7")
        case "forest-bad-object":
            return checkCompletion("task4")
        case "forest-good-object":
            return checkCompletion("task4")
        case "cycles-object":
            return checkCompletion("task2")
        case "walk-object":
            return checkCompletion("task1")
        case "trashbin-object":
            return checkCompletion("task8")
        default:
            return true
        }
    }
    

    
    func getUserTask(_ documentId: String) -> TaskData? {
        return userTaskDataMock.first { $0.documentId == documentId }
    }
    
    
    func checkCompletion(_ documentId: String) -> Bool{
        guard let task = getTaskx(documentId) else {return false}
        guard let taskData = getUserTask(documentId) else {return false}
        if(taskData.progress >= task.target){
            return true
        } else {
            return false
        }
        
    }
    
    func getCompletionTaskCount() -> Int{
        var count = 0
        for index in 1...8 {
            if(checkCompletion("task\(index)")){
                count += 1
            }
        }
        return count
    }
    var body: some View {
        NavigationView{
            VStack{
                HStack(spacing: 16){
                    
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Pulau")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                            HStack{
                                Text("Pertama")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.down.circle")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width * 1.5/3, alignment: .topLeading)
                        .background(Color(red: 0.15, green: 0.65, blue: 0.51))
                        .cornerRadius(20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Aksi Selesai")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.black)
                        HStack{
                            Text("\(getCompletionTaskCount()) / 8")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(Color("green600"))
                            Spacer()
                            Image(systemName: "arrow.down.circle")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(12)
                    .frame(width: .infinity, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(20)
                }
                Spacer()
                ZStack(alignment: .center){
                    ZStack(alignment: .center){
                        Image("landscape-1")
                            .opacity(!isCompleted("landscape-1") ? 1 : 0)
                        Image("cars-object")
                            .opacity(!isCompleted("cars-object") ? 1 : 0)
                        Image("trash-object")
                            .opacity(!isCompleted("trash-object") ? 1 : 0)
                        Image("river-bad-object")
                            .opacity(!isCompleted("river-bad-object") ? 1 : 0)
                        Image("forest-bad-object")
                            .opacity(!isCompleted("forest-bad-object") ? 1 : 0)
                    }
                    ZStack(alignment: .center){
                        Image("landscape-2")
                            .opacity(isCompleted("landscape-2") ? 1 : 0)
                        Image("cycles-object")
                            .opacity(isCompleted("cycles-object") ? 1 : 0)
                        Image("walk-object")
                            .opacity(isCompleted("walk-object") ? 1 : 0)
                        Image("forest-good-object")
                            .opacity(isCompleted("forest-good-object") ? 1 : 0)
                        Image("trashbin-object")
                            .opacity(isCompleted("trashbin-object") ? 1 : 0)
                        Image("bus-object")
                            .opacity(isCompleted("bus-object") ? 1 : 0)
                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 2) {
                    VStack(spacing: 6){
                        Image(systemName: "square.dashed")
                        Text("Island")
                            .font(
                                Font.custom("SF Pro Text", size: 10)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("green600"))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 6){
                        Image(systemName: "square.dashed")
                        Text("Action")
                            .font(
                                Font.custom("SF Pro Text", size: 10)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .opacity(0.5)
                    
                    
                    
                    
                    
                    VStack(spacing: 6){
                        Image(systemName: "square.dashed")
                        Text("Profile")
                            .font(
                                Font.custom("SF Pro Text", size: 10)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .opacity(0.5)
                    VStack(spacing: 6){
                        Image(systemName: "square.dashed")
                        Text("Discover")
                            .font(
                                Font.custom("SF Pro Text", size: 10)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .opacity(0.5)
                    
                }
                .padding(.horizontal, 26)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(99)
            }
            .padding(16)
            .background(
                Image("island1-background-after")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                    .ignoresSafeArea()
                
            )
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height )
        }
      
    }
}

struct TempHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TempHomeView()
    }
}

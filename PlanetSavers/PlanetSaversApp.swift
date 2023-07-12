//
//  PlantyApp.swift
//  Planty
//
//  Created by Muhammad Rezky on 28/06/23.
//



import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct PlantyApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
          OnboardingView()
              .previewInterfaceOrientation(.portrait)
              .preferredColorScheme(.light)
              .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}


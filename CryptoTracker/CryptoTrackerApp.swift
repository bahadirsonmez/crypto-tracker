//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 19.12.2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    @State private var showAlert = false
    @State private var alertData = AlertData.empty
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { notif in
                if let data = notif.object as? AlertData {
                    alertData = data
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertData.title,
                      message: alertData.message,
                      dismissButton: alertData.dismissButton)
            }
        }
    }
}

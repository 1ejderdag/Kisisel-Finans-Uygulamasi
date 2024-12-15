//
//  Kisisel_Finans_UygulamasiApp.swift
//  Kisisel-Finans-Uygulamasi
//
//  Created by Ejder Dağ on 2.11.2024.
//

import SwiftUI
import FirebaseCore


@main
struct Kisisel_Finans_UygulamasiApp: App {
    
    @StateObject var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
                
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(authViewModel)
        }
    }
}

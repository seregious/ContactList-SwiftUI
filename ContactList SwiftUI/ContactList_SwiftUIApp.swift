//
//  ContactList_SwiftUIApp.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

@main
struct ContactList_SwiftUIApp: App {
    
    @StateObject var contacts: ContactViewModel = ContactViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(contacts)
            }
            .accentColor(.black)
        }
    }
}

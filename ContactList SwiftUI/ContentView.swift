//
//  ContentView.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var contacts: ContactViewModel
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            BackgroundGradient()
            
            TabView {
                    MainListView(contacts: contacts)
                        .tabItem {
                            VStack{
                                Image(systemName: "person")
                                Text("Contact List")
                            }
                        }
                    
                DetailedListView(contacts: contacts)
                        .tabItem {
                            VStack{
                                Image(systemName: "book")
                                Text("Detailed List")
                            }
                        }
                }
            .tabViewStyle(PageTabViewStyle())
            
            plusButton(contacts: contacts)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





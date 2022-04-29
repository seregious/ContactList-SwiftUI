//
//  MainListView.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct MainListView: View {
    
    @ObservedObject var contacts: ContactViewModel
    
    var body: some View {
        ZStack {
                List {
                    ForEach(contacts.contactsList) { contact in
                        NavigationLink {
                            PersonalInfo(contacts: contacts, contact: contact)
                        } label: {
                            
                            ZStack {
                                RowBackground(height: 40)
                                
                                Text("\(contact.name) \(contact.surname)")
                                    .font(.headline)
                            }
                        }
                    }
                    .padding(5)
                    .listRowBackground(Color.clear)
                }
                .padding(20)
                .listStyle(.plain)
                .navigationTitle("Contacts")
                .onAppear{
                    UITableView.appearance().showsVerticalScrollIndicator = false
                    UITableView.appearance().separatorColor = .clear
                }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        let contacts = ContactViewModel()
        MainListView(contacts: contacts)
    }
}

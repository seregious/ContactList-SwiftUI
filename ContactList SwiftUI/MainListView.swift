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
        ZStack(alignment: .bottomTrailing) {
            
            List {
                ForEach(contacts.contactsList) { contact in
                    NavigationLink {
                        PersonalInfo(contacts: contacts, contact: contact)
                    } label: {
                        Text("\(contact.name) \(contact.surname)")
                            .font(.headline)
                    }
                }
                .padding()
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.ultraThinMaterial)
                        .padding(4)
                        .padding(.horizontal, 4)
                        .shadow(radius: 2, x: 5, y: 5)
                )
            }
            .padding(20)
            .listStyle(.plain)
            .navigationTitle("Contacts")

        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        let contacts = ContactViewModel()
        MainListView(contacts: contacts)
    }
}

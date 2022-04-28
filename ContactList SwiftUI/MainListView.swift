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
                    .modifier(rowBackground())
                }
                .padding(20)
                .listStyle(.plain)
                .navigationTitle("Contacts")
                .toolbar {
                    FilterButtons(contacts: contacts)
                }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        let contacts = ContactViewModel()
        MainListView(contacts: contacts)
    }
}

struct FilterButtons: View {
    
    @ObservedObject var contacts: ContactViewModel
    @State var filterCount = 0
    var filter: (type: String, image: String) {
        backgroundFilter()
    }
    
    var body: some View {
        HStack {
            Button(filter.type){
                filterCount += 1
                if filterCount > 4 {
                    filterCount = 1
                }
                contacts.filterContacts(sort: filterCount)
            }
            Image(systemName: filter.image)
        }
        .padding(.vertical, 3)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .frame(width: UIScreen.main.bounds.width / 3)
        }
    }
}

extension FilterButtons {
    func backgroundFilter () -> (String, String) {
        var type = ""
        var image = ""
        
        switch filterCount {
        case 1:
            type = "name"
            image = "chevron.down"
        case 2:
            type = "name"
            image = "chevron.up"
        case 3:
            type = "surnname"
            image = "chevron.down"
        case 4:
            type = "surname"
            image = "chevron.up"
        default:
            type = "filter"
            image = ""
        }
        
        return (type, image)
    }
}

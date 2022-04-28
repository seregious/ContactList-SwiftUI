//
//  DetailedListView.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct DetailedListView: View {
    
    @ObservedObject var contacts: ContactViewModel
    
    var body: some View {
        
        List{
            ForEach(contacts.contactsList) { contact in
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "phone.circle.fill")
                            Text("email: \(contact.email)")
                        }

                        HStack {
                            Image(systemName: "envelope.circle.fill")
                            Text("phone: \(contact.phone)")
                        }

                    }
                    
                } header: {
                    Text(("\(contact.name) \(contact.surname)"))
                }

            }
            .modifier(rowBackground())
        }
        .padding()
        .listStyle(.plain)
        .navigationTitle("Detailed Info")
    }
}

struct DetailedListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedListView(contacts: ContactViewModel())
    }
}

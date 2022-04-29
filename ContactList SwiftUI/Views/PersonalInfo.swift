//
//  PersonalInfo.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct PersonalInfo: View {
    
    @ObservedObject var contacts: ContactViewModel
    @State var showAlert = false
    let contact: Contact
    
    var body: some View {
        
        ZStack(alignment: .top) {
            BackgroundGradient()
            
            VStack(spacing: 40) {
                
                VStack(alignment: .center) {
                    Text("\(contact.name) \(contact.surname)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "phone.circle.fill")
                            Text("email: \(contact.email)")
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "envelope.circle.fill")
                            Text("phone: \(contact.phone)")
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.ultraThinMaterial)
                }
            .padding()
            
                VStack(spacing: 15) {
                    
                    NavigationLink {
                        NewContactView(contacts: contacts, contact: contact)
                    } label: {
                        Text("Edit")
                    }
                    .buttonStyle(ButtonView())
                    
                    Button("Delete") {
                        showAlert.toggle()
                    }
                    .buttonStyle(ButtonView())
                    .alert("Do you really want to delete \(contact.name)?", isPresented: $showAlert) {
                        Button("Yes, please", role: .destructive) {
                            contacts.deleteContact(contact: contact)
                        }
                        Button("No, no, no", role: .cancel){}
                    }
                }
            
            }
        }
        
    }
}

struct PersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        let contact = ContactViewModel().contactsList[1]
        PersonalInfo(contacts: ContactViewModel(), contact: contact)
    }
}

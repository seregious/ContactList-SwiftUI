//
//  NewContactView.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct NewContactView: View {
    
    @ObservedObject var contacts: ContactViewModel
    @Environment(\.presentationMode) var presentationMode

    @State var name = ""
    @State var surname = ""
    @State var photo = ""
    @State var email = ""
    @State var phone = ""
    
    var contact: Contact? = nil
    
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            ScrollView {
                VStack {
                    VStack(spacing: 30) {

                        TextFieldView(field: $name, title: "Name")
                        TextFieldView(field: $surname, title: "Surname")
                        TextFieldView(field: $email, title: "e-mail")
                        TextFieldView(field: $phone, title: "Phone number")
                        
                    }
                    .padding(20)
                    .padding(.vertical, 20)
                   }
                .padding(20)
                
                Button("Save") {
                    save()
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonView())
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonView())

            }
            .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
        }
        .navigationBarHidden(true)
        .onAppear{
            newOrEdit()
        }
    }

}

struct NewContactView_Previews: PreviewProvider {
    static var previews: some View {
        let contacts = ContactViewModel()
        NewContactView(contacts: contacts)
    }
}

struct TextFieldView: View {
    
    @Binding var field: String
    let title: String
    
    var body: some View {
        
        VStack {
            
            Text(title)
            
            TextField("Enter your " + title, text: $field)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.ultraThinMaterial)
            }
        }
    }
}

extension NewContactView {
    
    func saveNewContact() {
        contacts.addContact(name: name, surname: surname, email: email, phone: phone)
    }
    
    func saveOldContact() {
        let contact = Contact(name: name, surname: surname, email: email, phone: phone)
        contacts.updateContact(contact: contact)
    }
    
    func save() {
        if contact == nil {
        saveNewContact()
        } else {
            saveOldContact()
        }
    }
    
    func newOrEdit() {
        if let contact = contact {
            name = contact.name
            surname = contact.surname
            email = contact.email
            phone = contact.phone
        }
    }
}

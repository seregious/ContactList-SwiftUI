//
//  NewContactView.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import SwiftUI

struct NewContactView: View {
    
    enum Field {
        case name
        case surname
        case email
        case phone
    }
    
    @ObservedObject var contacts: ContactViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var lastField = false
    
    @State private var showAlert = false
    @FocusState private var focus: Field?
    @FocusState private var lastFocus: Bool
    
    var contact: Contact? = nil
    
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            ScrollView {
                VStack {
                    VStack(spacing: 30) {

                        TextFieldView(field: $name, title: "Name")
                            .focused($focus, equals: .name)
                        TextFieldView(field: $surname, title: "Surname")
                            .focused($focus, equals: .surname)
                        TextFieldView(field: $email, title: "e-mail")
                            .focused($focus, equals: .email)
                        TextFieldView(field: $phone, title: "Phone number")
                            .focused($focus, equals: .phone)
                            .focused($lastFocus)
                        
                    }
                    .padding(20)
                    .padding(.vertical, 20)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button(!lastField ? "Next" : "Done") {
                                if !lastField {
                                    changeFocus()
                                } else {
                                    lastFocus = false
                                }
                            }
                        }
                    }
                   }
                .padding(20)
                
                Button("Save") {
                    checkInput()
                }
                .buttonStyle(ButtonView())
                .alert("Fill in at least one field", isPresented: $showAlert) {}
                
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
    
    func checkInput() {
        if name.count > 2 ||
            surname.count > 2 ||
            email.count > 2 ||
            phone.count > 2 {
            save()
            presentationMode.wrappedValue.dismiss()
        } else {
            showAlert.toggle()
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
    
    func changeFocus() {
        if name.isEmpty {
            focus = .name
        } else if surname.isEmpty {
            focus = .surname
        } else if email.isEmpty {
            focus = .email
        } else if phone.isEmpty {
            focus = .phone
            lastField = true
        }
    }
}

//
//  ContactViewModel.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import Foundation

class ContactViewModel: ObservableObject {
    
    @Published var contactsList: [Contact] = [] {
        didSet {
            saveContacts()
        }
    }
    
    init() {
        getContacts()
    }
    
    func getContacts() {
        contactsList = StorageManager.shared.loadContacts()
    }
    
    func fakeData() {
            addContact(name: "John", surname: "Lennon", email: "lennon@beatles.com", phone: "444-555")
            addContact(name: "Paul", surname: "Mccartney", email: "mccartney@beatles.com", phone: "333-888")
            addContact(name: "George", surname: "Harrison", email: "harrison@beatles.com", phone: "666-111")
            addContact(name: "Ringo", surname: "Starr", email: "starr@beatles.com", phone: "999-444")
    }
    
    func addContact(name: String = "", surname: String = "", photo: String = "", email: String = "", phone: String = "") {
        let newContact = Contact(
            name: name,
            surname: surname,
            email: email,
            phone: phone
        )
        contactsList.append(newContact)
    }
    
    func deleteContact(contact: Contact) {
        if let index = contactsList.firstIndex(of: contact) {
            contactsList.remove(at: index)
        }
        saveContacts()
    }
    
    func updateContact(contact: Contact) {
        if let index = contactsList.firstIndex(of: contact) {
            contactsList[index] = contact.updateContact()
        }
        saveContacts()
    }
    
    func saveContacts() {
        StorageManager.shared.saveContacts(for: contactsList)
    }
}

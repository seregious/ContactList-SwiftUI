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
        fakeData() //comment this line for clear list
    }
    
    func fakeData() {
        let fakeContacts = DataManager.shared.makeFakeContacts()
        contactsList += fakeContacts
    }
    
    func getContacts() {
        contactsList = StorageManager.shared.loadContacts()
    }
    
    
    func addContact(name: String = "", surname: String = "", email: String = "", phone: String = "") {
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
    
    func filterContacts(sort: Int) {
        contactsList = contactsList.sorted(by: { a, b in
            switch sort {
            case 1:
                return a.name < b.name
            case 2:
                return a.name > b.name
            case 3:
                return a.surname < b.surname
            default:
                return a.surname > b.surname
            }
        })
    }
}

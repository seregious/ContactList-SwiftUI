//
//  ContactModel.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import Foundation

struct Contact: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let surname: String
    let email: String
    let phone: String
    
    init(id: String = UUID().uuidString,
         name: String,
         surname: String,
         email: String,
         phone: String
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.phone = phone
    }
    
    func updateContact(name: String, surname: String, email: String, phone: String) -> Contact {
        Contact(id: id, name: name, surname: surname, email: email, phone: phone)
    }
}

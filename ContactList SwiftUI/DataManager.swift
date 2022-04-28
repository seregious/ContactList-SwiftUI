//
//  DataManager.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 28.04.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let names = ["John", "Paul", "George", "Ringo", "Eric", "Jack", "Ginger", "Jimmy", "Robert", "John Paul", "John"]
    private let surnames = ["Lennon", "McCartney", "Harrison", "Starr", "Clapton", "Bruce", "Baker", "Page", "Plant", "Jones", "Bonham"]
    
    private func makeEmail(surname: String) -> String {
            var suffix = ""
            switch Int.random(in: 1...3) {
            case 1:
                suffix = "beatles"
            case 2:
                suffix = "cream"
            default:
                suffix = "ledzeppelin"
            }
            return "\(surname.lowercased())@\(suffix).com"

    }
    
    private func makeNumbers() -> String {
        "\(Int.random(in: 100...999)) - \(Int.random(in: 100...999))"
    }
    
    func makeFakeContacts() -> [Contact] {
        let names = names.shuffled()
        let surnames = surnames.shuffled()
        var fakeContacts = [Contact]()
        
        for (name, surname) in zip(names,surnames) {
            let email = makeEmail(surname: surname)
            let phone = makeNumbers()
            let contact = Contact(name: name, surname: surname, email: email, phone: phone)
            fakeContacts.append(contact)
        }
        return fakeContacts
    }
    
    private init() {}
}

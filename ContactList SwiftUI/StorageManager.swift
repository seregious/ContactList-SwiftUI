//
//  StorageManager.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 27.04.2022.
//

import Foundation
import SwiftUI

final class StorageManager {
    
    static var shared = StorageManager()
    
    @AppStorage("contact") private var contactData: Data?
    
    
    func saveContacts(for contacts: [Contact]){
        contactData = try? JSONEncoder().encode(contacts)
    }
    
    func loadContacts() -> [Contact] {
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: contactData ?? Data()) else {return []}
        return contacts
    }
    
    private init() {}
}

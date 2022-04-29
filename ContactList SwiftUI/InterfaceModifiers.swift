//
//  InterfaceModifiers.swift
//  ContactList SwiftUI
//
//  Created by Сергей Иванчихин on 28.04.2022.
//

import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(colors: [.teal, .green], startPoint:  .bottomTrailing , endPoint: .topLeading)
            .ignoresSafeArea()
    }
}

struct ButtonView: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(10)
            .padding(.horizontal, 50)
            .foregroundColor(.black)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThinMaterial)
            }
    }
}

struct plusButton: View {
    
    @ObservedObject var contacts: ContactViewModel
    
    var body: some View {
        NavigationLink {
            NewContactView(contacts: contacts)
        } label: {
            
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 70, height: 70)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
                .padding(20)
                .overlay {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    
                }
        }
    }
}

struct FilterButtons: View {
    
    @ObservedObject var contacts: ContactViewModel
    @State var filterCount = 0
    var filter: (type: String, image: String) {
        backgroundFilter()
    }
    
    var body: some View {        
        Button {
            filterCount += 1
            if filterCount > 4 {
                filterCount = 1
            }
            contacts.filterContacts(sort: filterCount)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThinMaterial)
                    .frame(width: UIScreen.main.bounds.width / 2.5, height: 30)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
                
                HStack {
                    Image(systemName: filter.image)
                    Text(filter.type)
                }
            }
        }
    }
}

extension FilterButtons {
    func backgroundFilter () -> (String, String) {
        var type = ""
        var image = "chevron.right"
        
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
            type = "sort"
            image = "chevron.right"
        }
        
        return (type, image)
    }
}

struct RowBackground: View {
    let height: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.ultraThinMaterial)
            .frame(width: UIScreen.main.bounds.width - 100, height: height)
            .shadow(radius: 2, x: 5, y: 5)
    }
}

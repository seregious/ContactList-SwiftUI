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

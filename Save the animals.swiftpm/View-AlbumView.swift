//
//  View-AlbumView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AlbumView: View {
    @State var currentAnimal: Animal?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    let animals: [Animal]
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(AnimalType.data) { animalType in
                            Button {
//                                selectAnimal(with: animal)
                            } label: {
                                AquariumView(
                                    animalType: animalType,
                                    currentAnimal: currentAnimal, namespace: animation,
                                    showDetailPage: showDetailPage
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                }
                .navigationBarTitle("My aquariums")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            CloseButton()
                        }
                    }
                }
            }
        }
        .overlay(content: SheedIndicator.init)
        .overlay {
            if let animal = currentAnimal, showDetailPage {
                AnimalDetailView(
                    animal: animal,
                    namespace: animation,
                    showDetailPage: $showDetailPage,
                    id: "album\(animal.id)"
                )
            }
        }
    }
    
    func selectAnimal(with animal: Animal) {
        withAnimation(. interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            currentAnimal = animal
            showDetailPage = true
        }
    }
}

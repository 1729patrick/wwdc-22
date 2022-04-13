//
//  View-AlbumView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AlbumView: View {
    @Binding var showingAlbum: Bool
    @Binding var alwaysShowDetails: Bool
    
    @State var animateView: Bool = false
    
    @State var currentAnimalType: AnimalType?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    var animalsSaved: [AnimalType: Int]
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var close: some View {
        Button {
            dismiss()
        } label : {
            CloseButton()
        }
        .opacity(animateView ? 1 : 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("My aquarium")
                Spacer()
                close
            }
            .padding(20)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(AnimalType.data) { animalType in
                        Button {
                            selectAnimal(with: animalType)
                        } label: {
                            AquariumView(
                                animalType: animalType,
                                currentAnimalType: currentAnimalType,
                                namespace: animation,
                                showDetailPage: showDetailPage,
                                savedCount: animalsSaved[animalType] ?? 0
                            )
                        }
                        .disabled(animalsSaved[animalType] == nil)
                    }
                }
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
        }
        .overlay {
            if let animalType = currentAnimalType, showDetailPage {
                AnimalDetailView(
                    animal: Animal(
                        from: .init(x: 10, y: 0),
                        to: .init(x: 0, y: 0),
                        control1: .init(x: 0, y: 0),
                        control2: .init(x: 0, y: 0),
                        l2r: false,
                        type: currentAnimalType!
                    ),
                    namespace: animation,
                    showDetailPage: $showDetailPage,
                    alwaysShowDetails: $alwaysShowDetails,
                    id: "album\(animalType.id)",
                    size: 40 * max(1, animalType.scale * 0.7)
                ) {
                    
                }
            }
        }
        .onAppear(perform: onAppear)
        .background(.thickMaterial)
    }
    
    func onAppear() {
        print("onAppear")
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
    
    func selectAnimal(with animalType: AnimalType) {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            currentAnimalType = animalType
            showDetailPage = true
        }
    }
    
    func dismiss() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = false
        }
        
        showingAlbum = false
    }
}

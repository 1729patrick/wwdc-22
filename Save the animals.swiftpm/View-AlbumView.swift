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
    
    var feed: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
        } label: {
            Image("Feed")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
//                .spotlight(enabled: spotlight == 4, title: "Batata")
        }
        .buttonStyle(ScaledButtonStyle())
        .padding(.horizontal)
        .scaleEffect(animateView ? 1 : 0)
    }
    
    var close: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
            dismiss()
        } label : {
            Image("Close")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
        .scaleEffect(animateView ? 1 : 0)
    }
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("My aquarium")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(color: .black, radius: 1)
                
                Spacer()
                
                feed
                close
            }
            .padding([.top, .horizontal])
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(AnimalType.data) { animalType in
                        Button {
                            guard animalsSaved[animalType] != nil else {
                                SoundManager.shared.play(sound: WrongSound())
                                return
                            }
                            
                            selectAnimal(with: animalType)
                            SoundManager.shared.play(sound: ButtonSound())
                            
                            
                        } label: {
                            AquariumView(
                                animalType: animalType,
                                currentAnimalType: currentAnimalType,
                                namespace: animation,
                                showDetailPage: showDetailPage,
                                savedCount: animalsSaved[animalType] ?? 0
                            )
                        }
//                        .zIndex(showDetailPage && animalType == currentAnimalType ? 2 : 1)
                        .scaleEffect(animateView ? 1 : 0, anchor: .center)
                    }
                }
//                .opacity(animateView ? 1 : 0)
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
                )
            }
        }
        .onAppear(perform: onAppear)
        .background(.thickMaterial)
    }
    
    func onAppear() {
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

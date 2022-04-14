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
    @State var feed: Bool = false
    
    @State var currentAnimalType: AnimalType?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    var animalsSaved: [AnimalType: Int]
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var feedButton: some View {
        Button {
            startFeed()
        } label: {
            Image("Feed")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
            //                .spotlight(enabled: spotlight == 4, title: "Batata")
        }
        .buttonStyle(ScaledButtonStyle())
        .padding(.horizontal)
        .scaleEffect(animateView ? 1 : 0)
    }
    
    var closeButton: some View {
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
        .buttonStyle(ScaledButtonStyle())
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text("My aquarium")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(color: .black, radius: 1)
                    .scaleEffect(animateView ? 1 : 0, anchor: .leading)
                
                Spacer()
                
                feedButton
                closeButton
            }
            .padding()
            Divider()
            
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
                                savedCount: animalsSaved[animalType] ?? 0,
                                feed: $feed
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
    
    func startFeed() {
        guard feed == false else {
            return
        }
        
        withAnimation(.easeIn(duration: 0.15)){
            feed = true
        }
        
        SoundManager.shared.play(sound: ButtonSound())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            SoundManager.shared.play(sound: FeedSound())
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                SoundManager.shared.play(sound: FeedSound())
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    SoundManager.shared.play(sound: FeedSound())
                }
            }
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

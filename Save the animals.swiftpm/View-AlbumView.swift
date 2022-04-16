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
    @State var feeding: Bool = false
    
    @State var currentAnimalType: AnimalType?
    @State var showDetailPage: Bool = false
    
    var timeToFeedAgain: Int
    var feed: () -> Void
    
    @Namespace var animation
    
    var animalsSaved: [AnimalType: Int]
    var speciesSavedCount: Int


    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var feedDisabled: Bool {
        if !(speciesSavedCount >= 0) {
            return true
        }
        
        return timeToFeedAgain > 0
    }
    
    var timeLeftToFeed: String {
        if timeToFeedAgain < 10 {
            return "0\(timeToFeedAgain)"
        }
        
        return "\(timeToFeedAgain)"
    }
    
    var feedButton: some View {
        Button {
            executeFeed()
        } label: {
            Image("Feed")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
        }
        .padding(.horizontal)
        .opacity(feedDisabled ? 0.4 : 1)
        .overlay(alignment: .bottomLeading) {
            if timeToFeedAgain != .zero {
                HStack {
                    Text(timeLeftToFeed)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(.red)
                        .clipShape(Capsule())
                }
                .padding(.leading)
                    
            }
        }
        .buttonStyle(ScaledButtonStyle())
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
                Text("My aquariums")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(radius: 1)
                    .scaleEffect(animateView ? 1 : 0, anchor: .leading)
                
                Spacer()
                
                
                feedButton
                closeButton
            }
            .padding()
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(AnimalType.animals) { animalType in
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
                                feed: $feeding
                            )
                        }
                        .scaleEffect(animateView ? 1 : 0, anchor: .center)
                    }
                }
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
        .background(.regularMaterial)
    }
    
    func onAppear() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
    
    func executeFeed() {
        guard feeding == false && !(timeToFeedAgain > 0) else {
            SoundManager.shared.play(sound: WrongSound())
            return
        }
        
        withAnimation(.easeIn(duration: 0.15)){
            feeding = true
        }

        feed()
        
        SoundManager.shared.play(sound: ButtonSound())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            guard showingAlbum else { return }
            SoundManager.shared.play(sound: FeedSound())
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                guard showingAlbum else { return }
                SoundManager.shared.play(sound: FeedSound())
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    guard showingAlbum else { return }
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

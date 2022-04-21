//
//  View-AlbumView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AlbumView: View {
    @Binding var showingAlbum: Bool
    @Binding var alwaysShowDetails: Bool
    
    @State var animateView: Bool = false
    @State var feeding: Bool = false
    
    @State var currentSwimmerType: SwimmerType?
    @State var showingDetails: Bool = false
    
    var timeToFeedAgain: Int
    var feed: () -> Void
    
    @Namespace var animation
    
    var isSpecieSaved: (SwimmerType) -> Bool
    var getSpeciesSaved: (SwimmerType) -> Int
    
    var speciesSavedCount: Int
    let level: Int

    let columns = [
        GridItem(.flexible()),
       GridItem(.flexible()),
       GridItem(.flexible())
    ]
    
    var feedDisabled: Bool {
        if !(speciesSavedCount > 0) {
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
                    ForEach(SwimmerType.animals) { animalType in
                        Button {
                            guard isSpecieSaved(animalType) else {
                                SoundManager.shared.play(sound: WrongSound())
                                return
                            }
                            
                            selectAnimal(with: animalType)
                            SoundManager.shared.play(sound: ButtonSound())
                            
                            
                        } label: {
                            AquariumView(
                                animalType: animalType,
                                currentSwimmerType: currentSwimmerType,
                                namespace: animation,
                                showingDetails: showingDetails,
                                savedCount: getSpeciesSaved(animalType),
                                level: level,
                                feed: $feeding
                            )
                        }
                        .scaleEffect(animateView ? 1 : 0, anchor: .center)
                    }
                }
            }
        }
        .overlay {
            if let animalType = currentSwimmerType, showingDetails {
                AnimalDetailView(
                    animal: Swimmer(
                        from: .init(x: 10, y: 0),
                        to: .init(x: 0, y: 0),
                        control1: .init(x: 0, y: 0),
                        control2: .init(x: 0, y: 0),
                        l2r: false,
                        type: currentSwimmerType!
                    ),
                    namespace: animation,
                    showingDetails: $showingDetails,
                    alwaysShowDetails: $alwaysShowDetails,
                    id: "album\(animalType.id)",
                    size: (UIScreen.screenWidth / 10) * max(1, animalType.scale * 0.7)
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
        guard feedDisabled == false else {
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
    
    func selectAnimal(with animalType: SwimmerType) {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            currentSwimmerType = animalType
            showingDetails = true
        }
    }
    
    func dismiss() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = false
        }
        
        showingAlbum = false
    }
}

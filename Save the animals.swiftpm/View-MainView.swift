//
//  View-MainView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var startAnimation: CGFloat = 0
    
    @State private var animateView: Bool = false
    
    //    animal details
    @State var showDetailPage: Bool = false
    @State var currentAnimal: Animal?
    @State var showingAlbum: Bool = false
    @Namespace var animation
    
    @State var oilSpill: Bool = false
    
    //    album icon
    @State var albumScale: Double = 1
    
    //    var fake = Animal(
    //        from: .init(x: 0, y: UIScreen.screenHeight / 2 - 100),
    //        to: .init(x: 100, y: UIScreen.screenHeight / 2),
    //        control1: .init(x: 50, y: UIScreen.screenHeight / 2),
    //        control2: .init(x: 50, y: UIScreen.screenHeight / 2),
    //        l2r: true,
    //        speed: 50,
    //        image: "Spelaeogammarus sanctus",
    //        onDestroy: { }
    //    )
    
    @State var spotlight = 10
    
    var animals: some View {
        ForEach(viewModel.animals) { animal in
            AnimalView(
                animal: animal,
                alwaysShowDetails: viewModel.alwaysShowDetails,
                selected: showDetailPage && currentAnimal == animal,
                namespace: animation
            ) {
                SoundManager.shared.play(sound: FishSound())
                selectAnimal(with: animal)
            }
        }
    }
    
    var album: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
            showingAlbum = true
        } label: {
            Image("Aquarium")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .spotlight(enabled: spotlight == 3, title: "Batata")
        }
        .buttonStyle(ScaledButtonStyle())
        .scaleEffect(albumScale)
        .scaleEffect(animateView ? 1 : 0)
    }
    
    var header: some View {
        HStack {
            Spacer()
            
            Button {
                withAnimation {
                    oilSpill.toggle()
                }
            } label: {
                Text("Oil")
                    .padding()
                    .background(.red)
            }
            album
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        Image("Background")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .frame(
                                width: UIScreen.screenWidth,
                                height: UIScreen.screenHeight,
                                alignment: .top)
                            .overlay {
                                LinearGradient(
                                    colors: [
                                        .black.opacity(0.3),
                                        .black.opacity(0),
                                        .black.opacity(0),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .ignoresSafeArea()
                            }
                        
                        
                        OceanWaveView(progress: 0.7, waveHeight: 0.01, offset: startAnimation)
                            .fill(
                                LinearGradient(
                                    colors: oilSpill ?
                                    [
                                        .black.opacity(0.65),
                                        .black.opacity(0.8),
                                    ] :
                                    [
                                        Color("Light Blue").opacity(0.65),
                                        Color("Dark Blue").opacity(0.8),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                    }
                    .frame(width: size.width, height: size.height)
                    .overlay {
                        getSand(size: size)
                        WaterDropsView()
                        
                        animals
                    }
                }
                .padding(.leading, 4)
                .onAppear(perform: onAppear)
                .allowsHitTesting(spotlight > 4)
                .onTapGesture {
                    SoundManager.shared.play(sound: WrongSound())
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .onTapGesture {
                spotlight += 1
                
                if spotlight == 2 {
                    //                    selectAnimal(with: fake)
                }
            }
            
            header
            
            if showingAlbum {
                AlbumView(
                    showingAlbum: $showingAlbum,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    timeToFeedAgain: viewModel.timeToFeedAgain,
                    feed: viewModel.feed,
                    animalsSaved: viewModel.animalsSaved
                )
            }
            
            if let animal = currentAnimal, showDetailPage {
                AnimalDetailView(
                    animal: animal,
                    namespace: animation,
                    showDetailPage: $showDetailPage,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    id: animal.id.uuidString,
                    size: 75 * animal.type.scale,
                    onClose: {
                        saveAnimal(animal: animal)
                        currentAnimal = nil
                        
                        if spotlight == 2 {
                            spotlight += 1
                        }
                    }
                )
            }
            
        }
    }
    
    func onAppear() {
        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
            startAnimation = UIScreen.screenWidth - 70
        }
        
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
    
    func getSand(size: CGSize) -> some View {
        VStack {
            Spacer()
            SandWaveView(
                progress: 0.5,
                waveHeight: 0.015,
                offset: startAnimation
            )
            .fill(LinearGradient(
                colors: [Color("Light Gold"), Color("Dark Gold")],
                startPoint: .top,
                endPoint: .bottom)
            )
            .overlay {
                SandPlantsView(size: size)
            }
            .frame(width: size.width, height: 250)
        }
    }
    
    func selectAnimal(with animal: Animal) {
        if viewModel.alwaysShowDetails == true {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                currentAnimal = animal
                showDetailPage = true
            }
        }  else {
            saveAnimal(animal: animal)
        }
    }
    
    func saveAnimal(animal: Animal) {
        viewModel.save(animal: animal)
        scaleAlbum()
    }
    
    func scaleAlbum() {
        withAnimation(.linear(duration: 0.2).delay(0.3)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.15).delay(0.6)) {
            albumScale = 1
        }
    }
}


struct ScaledButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

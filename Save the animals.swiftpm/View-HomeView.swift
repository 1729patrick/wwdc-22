//
//  View-HomeView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var startAnimation: CGFloat = 0
    
    //    animal details
    @State var showDetailPage: Bool = false
    @State var currentAnimal: Animal?
    @State var showingAlbum: Bool = false
    @Namespace var animation
    
    //    album icon
    @State var albumScale: Double = 1
    var albumPosition: CGPoint {
        return CGPoint(x: UIScreen.screenWidth - 40, y: 30)
    }
    
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
                namespace: animation
            ) {
                selectAnimal(with: animal)
            }
        }
    }
    
    var feed: some View {
        Button {
            
        } label: {
            Image("Feed")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .spotlight(enabled: spotlight == 4, title: "Batata")
        }
        .buttonStyle(ScaledButtonStyle())
        .position(x: UIScreen.screenWidth - 120, y: 30)
    }
    
    var album: some View {
        return Button {
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
        .position(albumPosition)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack(alignment: .bottom) {
                    OceanWaveView(progress: 0.75, waveHeight: 0.01, offset: startAnimation)
                        .fill(LinearGradient(
                            colors: [Color("Light Blue"), Color("Dark Blue")],
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                        .overlay {
                            getSand(size: size)
                            WaterDropsView()
                            
                            //                        AnimalView(
                            //                            animal: fake,
                            //                            namespace: animation,
                            //                            spotlight: spotlight
                            //                        ) { }
                            //
                            animals
                            
                        }
                        .frame(width: size.width, height: size.height)
                    
                    feed
                    album
                    
                }
                .onAppear(perform: onAppear)
                .allowsHitTesting(spotlight > 4)
            }
            .background(.black)
            .ignoresSafeArea(.container, edges: .bottom)
            .overlay {
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
                            
                            if spotlight == 2 {
                                spotlight += 1
                            }
                        }
                    )
                }
            }
            //        .sheet(isPresented: $showingAlbum) {
            //            AlbumView(animals: [])
            //        }
            .onTapGesture {
                spotlight += 1
                
                if spotlight == 2 {
                    //                    selectAnimal(with: fake)
                }
            }
            
            if showingAlbum {
                AlbumView(
                    showingAlbum: $showingAlbum,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    animalsSaved: viewModel.animalsSaved
                )
            }
        }
    }
    
    func onAppear() {
        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
            startAnimation = UIScreen.screenWidth - 70
        }
    }
    
    func getSand(size: CGSize) -> some View {
        VStack {
            Spacer()
            SandWaveView(
                progress: 0.5,
                waveHeight: 0.01,
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
        withAnimation(.linear(duration: 0.3).delay(0.5)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.3).delay(0.8)) {
            albumScale = 1
        }
    }
}


struct ScaledButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

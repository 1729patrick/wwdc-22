//
//  View-HomeView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct HomeView: View {
    @SceneStorage("showDetails") var showDetails: Bool?
    @StateObject var viewModel = ViewModel()
    
    //  ocean and sand  wave
    @State var progress: CGFloat = 0.5
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
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack(alignment: .bottom) {
                OceanWaveView(progress: progress, waveHeight: 0.01, offset: startAnimation)
                    .fill(LinearGradient(
                        colors: [Color("Light Blue"), Color("Dark Blue")],
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                    .overlay {
                        VStack {
                            Spacer()
                            SandWaveView(
                                progress: progress,
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
                        
                        ForEach(viewModel.animals) { animal in
                            AnimalView(animal: animal, namespace: animation) {
                                selectAnimal(with: animal)
                            }
                        }
                        WaterDropsView()
                    }
                    .frame(width: size.width, height: size.height)
                
                Button {
                    showingAlbum = true
                } label: {
                    Text("🌎")
                        .font(.system(size: 50))
                }
                .buttonStyle(ScaledButtonStyle())
                .scaleEffect(albumScale)
                .position(albumPosition)
            }
            .onAppear(perform: onAppear)
        }
        .background(.black)
        .ignoresSafeArea(.container, edges: .bottom)
        .overlay {
            if let animal = currentAnimal, showDetailPage {
                AnimalDetailView(
                    animal: animal,
                    namespace: animation,
                    showDetailPage: $showDetailPage
                ) {
                    saveAnimal(animal: animal)
                }
            }
        }
        .sheet(isPresented: $showingAlbum) {
            Text("AAAA")
        }
    }
    
    func onAppear() {
        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
            startAnimation = UIScreen.screenWidth - 70
        }
    }
    
    func selectAnimal(with animal: Animal) {
        if showDetails == true {
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
        withAnimation(.linear(duration: 0.3).delay(0.1)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.3).delay(0.3)) {
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

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
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
//    to refactor
    @State var albumScale: Double = 1
    var albumPosition: CGPoint {
        return CGPoint(x: UIScreen.screenWidth - 40, y: 30)
    }
    
    func scaleWorld() {
        withAnimation(.linear(duration: 0.3).delay(0.1)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.3).delay(0.3)) {
            albumScale = 1
        }
    }
    
    var savedAnimals: [Animal] {
        viewModel.animals.filter { $0.saved == true }
    }
    
    func saveAnimal(animal: Animal) {
        viewModel.save(animal: animal)
        scaleWorld()
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
                        ForEach(viewModel.animals) { animal in
                                AnimalView(animal: animal) {
                                    saveAnimal(animal: animal)
                                }
                        }
                        
                        WaterDropsView()
                    }
                    .frame(width: size.width, height: size.height)
                
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
                
                Text("🌎")
                    .font(.system(size: 50))
                    .scaleEffect(albumScale)
                    .position(albumPosition)
            }
            .onAppear {
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
                    startAnimation = size.width - 70
                }
            }
        }
        .background(.black)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

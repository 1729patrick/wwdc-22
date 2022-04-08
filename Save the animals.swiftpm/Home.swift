//
//  Home.swift
//  WaterWave (iOS)
//
//  Created by Balaji on 12/02/22.
//

import SwiftUI
import Combine

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


struct AnimalView: View {
    @ObservedObject var animal: AnimalModel
 
    var body: some View {
//        animal.path.stroke(style: StrokeStyle(lineWidth: 0.5))
        animal.aircraft
    }
}


struct Home: View {
    @StateObject var viewModel = ViewModel()
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
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
                        ZStack {
                            Button(action: {
                                viewModel.addAnimal()
                            }) {
                                Text("Add animal")
                            }
                            .offset(y: -200)
                        }
                        
                        ForEach(viewModel.animals) { animal in
                            AnimalView(animal: animal)
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
                
                
                
                
                
            }
            .onAppear {
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
                    startAnimation = size.width - 70
                }
            }
        }
        .background(.black)
        .ignoresSafeArea()
        
        
    }
}



//https://stackoverflow.com/questions/60521118/how-to-move-a-view-shape-along-a-custom-path-with-swiftui

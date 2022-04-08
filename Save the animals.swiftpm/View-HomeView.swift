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

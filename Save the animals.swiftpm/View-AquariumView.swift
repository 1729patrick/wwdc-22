//
//  View-AquariumView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 10/04/22.
//

import SwiftUI

struct AquariumView: View {
    let colors = [
        "Red",
        "Gold",
        "Purple",
        "Midnight",
        "Orange",
        "Teal",
        "Pink",
        "Dark Gray",
        "Gray"
    ]
    
    @State var color: Color = .blue
    
    //  ocean and sand  wave
    @State var startAnimation: CGFloat = 0
    @State var fishAnimation: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .stroke(color, lineWidth: 3)
                .frame(width: 55, height: 10)
            
            ZStack {
                Capsule()
                    .stroke(.clear)
                    .frame(width: 102.5, height: 70)
                    .overlay {
                        OceanWaveView(
                            progress: 0.75,
                            waveHeight: 0.1,
                            offset: startAnimation
                        )
                        .fill(LinearGradient(
                            colors: [
                                Color("Light Blue"),
                                Color("Dark Blue")
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                        .clipShape(Capsule())
                        
                        Text("🐠")
                            .font(.system(size: 35))
                            .rotationEffect(Angle(degrees: fishAnimation == 0 ? -15 : 15))
                            .offset(x: 0, y: fishAnimation == 0 ? 15 : 5)
                        
                    }
                
                Capsule()
                    .stroke(color, lineWidth: 3)
                    .frame(width: 100, height: 70)
            }
        }
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
            startAnimation = UIScreen.screenWidth - 70
        }
        
        withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: true)){
            fishAnimation = 1
        }
        
        color = Color(colors.randomElement() ?? "Gold")
    }
}

//
//  View-AquariumView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 10/04/22.
//

import SwiftUI

struct AquariumView: View {
    let animalType: AnimalType
    let currentAnimalType: AnimalType?
    var namespace: Namespace.ID
    var showDetailPage: Bool
    let savedCount: Int
    
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
    
    @State var color: Color = Color("Light Blue")
    
    //  ocean and sand  wave
    @State var startAnimation: CGFloat = 0
    @State var fishAnimation: CGFloat = 0
    
    var disabled: Bool {
        print("savedCount", savedCount)
        
        return !(savedCount > 0)
    }
    
    var rotation: Angle {
        if disabled {
            return Angle(degrees: 0)
        }
        
        if showDetailPage && animalType == currentAnimalType {
            return Angle(degrees: 0)
        }
        
        return Angle(degrees: fishAnimation == 0 ? -15 : 15)
    }
    
    var y: Double {
        if disabled {
            return 0
        }
        
        return fishAnimation == 0 ? 15 : 5
    }
    
    var size: Double {
        40 * max(1, animalType.scale * 0.7)
    }
    
    var scale : Double {
        if showDetailPage && animalType == currentAnimalType {
            return (UIScreen.screenWidth * 0.85) / size
        }
        
        return 1
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Capsule()
                    .stroke(color, lineWidth: 3)
                    .frame(width: 55, height: 10)
                
                ZStack {
                    OceanWaveView(
                        progress: 0.75,
                        waveHeight: 0.1,
                        offset: startAnimation
                    )
                    .fill(
                        LinearGradient(
                            colors: [
                                Color("Light Blue"),
                                Color("Dark Blue")
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                        
                    )
                    .frame(width: 102, height: 70)
                    .clipShape(Capsule())
                    
                    Capsule()
                        .stroke(color, lineWidth: 3)
                        .frame(width: 100, height: 70)
                    
                }
            }
            .opacity(disabled ? 0.15 : 1)
        }
        .overlay {
            Image(animalType.image)
                .resizable()
                .scaledToFit()
                .if(disabled) { image in
                    image.colorMultiply(.black)
                }
                .frame(
                    width: size,
                    height: size
                )
                .scaleEffect(scale)
                .matchedGeometryEffect(id: "album\(animalType.id)", in: namespace)
                .rotationEffect(rotation)
                .offset(x: 0, y: y)
            
            if disabled {
                Image(systemName: "lock.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color("Light Blue"))
                    .shadow(radius: 10)
            }
        }
        .padding(.top)
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)){
            startAnimation = UIScreen.screenWidth - 70
        }
        
        withAnimation(.linear(duration: 4).repeatForever(autoreverses: true)){
            fishAnimation = 1
        }
        
        //        color = Color(colors.randomElement() ?? "Gold")
    }
}

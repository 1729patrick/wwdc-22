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
    @Binding var feed: Bool
    
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
    
    @State var color: Color = Color("Gray")
    @State var feeding: Bool = false
    @State var food: Bool = true
    
    //  ocean and sand  wave
    @State var startAnimation: CGFloat = 0
    @State var fishAnimation: CGFloat = 0
    
    var disabled: Bool {
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
    
    var scale: Double {
        if showDetailPage && animalType == currentAnimalType {
            return (UIScreen.screenWidth * 0.85) / size
        }
        
        return 1
    }
    
    var foods: some View {
        Group {
            Capsule()
                .fill(Color("Light Gold"))
                .frame(width: 6, height: 6)
                .scaleEffect(food ? 0 : 1)
                .offset(
                    x: 0,
                    y: food ? 40.0 : 15.0
                )
            Capsule()
                .fill(Color("Light Gold"))
                .frame(width: 5, height: 8)
                .scaleEffect(food ? 0 : 1)
                .offset(
                    x: 7,
                    y: food ? 45.0 : 20.0
                )
            Capsule()
                .fill(Color("Light Gold"))
                .frame(width: 4, height: 8)
                .scaleEffect(food ? 0 : 1)
                .offset(
                    x: -7,
                    y: food ? 50.0 : 20.0
                )
            Capsule()
                .fill(Color("Light Gold"))
                .frame(width: 4, height: 6)
                .scaleEffect(food ? 0 : 1)
                .offset(
                    x: 0,
                    y: food ? 55.0 : 25.0
                )
        }
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
            
            if disabled == false {
                VStack {
                Image("Feed Pot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                    .rotationEffect(Angle(degrees: feeding ? -80 : -40))
                    .scaleEffect(feed ? 1 : 0)
                    .overlay(alignment: .leading) {
                        foods
                    }
                    Spacer()
                }
            }
            
        }
//        .overlay(alignment: .bottomLeading) {
//            if savedCount > 0 {
//                    Text("\(savedCount)")
//                        .font(.caption2)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 4)
//                        .padding(.vertical, 2)
//                        .background(.white)
//                        .foregroundColor(.blue)
//                        .clipShape(Capsule())
//            }
//        }        
        .onAppear(perform: onAppear)
        .onChange(of: feed, perform: onFeedChange)
        .padding(.top)
        .padding(.top)
        
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
    
    func onFeedChange(_: Bool) {
        guard disabled == false else {
            return
        }
        
        guard feed == true else {
            return
        }
        
        withAnimation(.easeInOut(duration: 0.8).repeatCount(5, autoreverses: true)){
            feeding = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            food = false
            
            withAnimation(
                .easeInOut(duration: 1.6).repeatCount(3, autoreverses: false)
            ){
                food = true
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(.easeOut(duration: 0.15)){
                feed = false
                
                feeding = false
                food = true
            }
        }
    }
}

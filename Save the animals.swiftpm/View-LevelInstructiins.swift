//
//  View-LevelInstructions.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 15/04/22.
//

import SwiftUI

struct LevelInstructionView: View {
    var level: Int
    var animalsSavedCount: Int
    var onGo: () -> Void
    
    @State private var animateView: Bool = false
    
    var description: String {
        switch level {
        case 1:
            return "Fish are swimming in the ocean, but the number of species is decreasing year after year, fighting pollution, heating water, oil spills, etc. Now you must save some fish that are in the ocean and put them safely in aquariums."
        case 2:
            return "Oh no, there was an oil leak. Tons and tons of fish die in this kind of accident. Save as many fish as you can. Go! Go! Go!"
        case 3:
            return "You have already saved \(animalsSavedCount) fish, congratulations! All are safe in their aquariums, but they are out of food. Your goal is to feed them. The more food you give them, the faster they will reproduce and the faster they will return to the ocean."
        case 4:
            return "You are taking such good care of your fish, amazing! Some pieces of plastic, cigarette butts and glass appeared in the ocean, and now the fish are in danger, as they can mistake these objects for food. Return to the ocean and remove these objects."
        case 5:
            return "Good, you did a great job removing all the garbage from the ocean. Now the protection of endangered animals is in your hands. Keep taking care of the fish, hold the ocean clean and fight oil leaks."
        default:
            return ""
        }
    }
    
    var hint: [String] {
        switch level {
        case 1, 2:
            return ["- Tap on the fishes -"]
        case 3:
            return ["- Go to the aquariums and feed the fishes -"]
        case 4:
            return ["- Tap on the objects -"]
        case 5:
            return ["- Tap on the fishes -", "- Tap on the objects -", "- Feed the fishes -"]
        default:
            return []
        }
        
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                
                Text("LEVEL \(level)")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(radius: 1)
                    .multilineTextAlignment(.center)
                    .scaleEffect(animateView ? 1 : 0)
                
                Text(description)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .shadow(radius: 1)
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                    .scaleEffect(animateView ? 1 : 0)
                    .padding(.top)
                
                VStack {
                    ForEach(hint, id: \.self) {
                        Text($0)
                            .font(.system(size: 18))
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                            .shadow(radius: 1)
                            .multilineTextAlignment(.center)
                            .scaleEffect(animateView ? 1 : 0)
                            .scaleEffect(animateView ? 1 : 0)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.top)
                
                Spacer()
            }
            
            Button {
                onGo()
                SoundManager.shared.play(sound: ButtonSound())
            } label : {
                Image("Go")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            }
            .buttonStyle(ScaledButtonStyle())
            .scaleEffect(animateView ? 1 : 0)
            
            
        }
        .padding(.bottom, 100)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
}

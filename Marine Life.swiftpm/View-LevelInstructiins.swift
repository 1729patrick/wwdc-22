//
//  View-LevelInstructions.swift
//  Marine Life
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
            return "Fish are swimming in the ocean, but the number of species is decreasing year after year, due to pollution, warming water and oil spills. Now you must save some fish that are in the ocean and put them safely in aquariums."
        case 2:
            return "Oh no, there was an oil spill. Tons of fish die in this type of accident. Save as many fish as you can. Go! Go! Go!"
        case 3:
            return "You have already saved \(animalsSavedCount) fish, congratulations! All are safe in their aquariums, but they are out of food. Your goal is to feed them. The more food you give them, the faster they will reproduce and the faster they will return to the ocean."
        case 4:
            return "You are taking such good care of your fish, amazing! Some pieces of plastic, cigarette butts and glass have appeared in the ocean, and now the fish are in danger as they can mistake these objects for food. It's time for you to remove the garbage from the ocean so the fish don't eat it."
        case 5:
            return "You saved the lives of many fish by removing garbage from the ocean, fascinating! Many species are already in your aquarium, but some are still endangered in the ocean, now it's time to save them."
        case 6:
            return "I hope this app has helped you to realize that the lives of marine animals are in our hands. Keep taking care of the fish, keep the ocean clean and fight oil spills. We can change the world!"
        default:
            return ""
        }
    }
    
    var hint: [String] {
        switch level {
        case 1:
            return ["- Tap on the fish -"]
        case 2:
            return ["- Keep tapping on the fish -"]
        case 3:
            return ["- Go to the aquariums and feed the fish -"]
        case 4:
            return ["- Return to the ocean and tap on the objects -"]
        case 5:
            return ["- Tap on the fish -"]
        default:
            return []
        }
    }
    
    var levelTitle: String {
        if level == 5 {
            return "LAST LEVEL"
        } else if level == 6 {
            return "YOU WIN!"
        }
        
        return "LEVEL \(level)"
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(levelTitle)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .scaleEffect(animateView ? 1 : 0)
            
            Text(description)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .shadow(radius: 1)
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                .scaleEffect(animateView ? 1 : 0)
                .padding(.top)
                .padding(.horizontal, UIDevice.isIPad ? UIScreen.screenWidth * 0.2 : 0)
                .minimumScaleFactor(0.1)
            
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
                        .padding(.bottom, 1)
                }
            }
            .padding(.top)
            
            
            Button {
                onGo()
                SoundManager.shared.play(sound: ButtonSound())
            } label : {
                Image(level == 6 ? "Close" : "Go")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            }
            .buttonStyle(ScaledButtonStyle())
            .scaleEffect(animateView ? 1 : 0)
            .padding(.top, 40)
            
            Spacer()
        }
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

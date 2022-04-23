//
//  View-InstructionView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 14/04/22.
//

import SwiftUI

struct InstructionView: View {
    var onStart: () -> Void
    
    @State private var page: Int = 0
    @State private var animateView: Bool = false
    
    var pages = [
        "Welcome to Marine Life.",
        "In the wild, only the strongest survive. But these days, even the strongest are fighting humans to survive.",
        "Now it is your turn. You will be responsible for saving endangered marine animals in Brazil.",
        "We can all collaborate for the preservation of marine life, both in Brazil and in the world.",
        "What can you do, it looks like a drop in the middle of the ocean, but without it, the ocean would be smaller.",
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Marine Life")
                    .font(.system(size: 26))
                    .fontWeight(.bold)
                    .shadow(radius: 1)
                    .scaleEffect(animateView ? 1 : 0)
                Spacer()
                Text("\(page + 1)/\(pages.count)")
                    .font(.system(size: 26))
                    .fontWeight(.bold)
                    .shadow(radius: 1)
                    .scaleEffect(animateView ? 1 : 0)
            }
            .padding(.top)
            
            Spacer()
            
            ZStack {
                ForEach(0..<pages.count) { index in
                    Text(pages[index])
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .lineSpacing(10)
                        .multilineTextAlignment(.center)
                        .scaleEffect(index == page ? 1 : 0)
                        .opacity(index == page ? 1 : 0)
                        .minimumScaleFactor(0.1)
                }
                
            }
            .padding(.horizontal, UIDevice.isIPad ? UIScreen.screenWidth * 0.2 : 0)
            .scaleEffect(animateView ? 1 : 0)
            
            ZStack {
                Button {
                    guard page < pages.count - 1 else {
                        return
                    }
                    
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                        page += 1
                    }
                    
                    SoundManager.shared.play(sound: ButtonSound())
                } label : {
                    Image("Continue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                }
                .scaleEffect(page == pages.count - 1 ? 0 : 1)
                .opacity(page == pages.count - 1 ? 0 : 1)
                .buttonStyle(ScaledButtonStyle())
                .disabled(page == pages.count - 1)
                .padding(.top, UIDevice.isIPad ? 100 : 40)
                
                Button {
                    SoundManager.shared.play(sound: ButtonSound())
                    onStart()
                } label : {
                    Image("Start")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                }
                .scaleEffect(page == pages.count - 1 ? 1 : 0)
                .opacity(page == pages.count - 1 ? 1 : 0)
                .buttonStyle(ScaledButtonStyle())
                .disabled(page != pages.count - 1)
                .padding(.top, 40)
            }
            .scaleEffect(animateView ? 1 : 0)
            
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

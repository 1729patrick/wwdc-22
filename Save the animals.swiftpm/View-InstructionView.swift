//
//  View-InstructionView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 14/04/22.
//

import SwiftUI

struct InstructionView: View {
    @Binding var showInstructions: Bool
    @State var page: Int = 0
    @State var animateView: Bool = false
    
    var pages = [
        "1 The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.",
        "2 The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.",
        "3 The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.",
        "4 The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.",
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer()
                    Text("\(page + 1)/\(pages.count)")
                        .font(.system(size: 26))
                        .fontWeight(.heavy)
                        .shadow(radius: 1)
                        .scaleEffect(animateView ? 1 : 0)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    ForEach(0..<pages.count) {
                        Text(pages[$0])
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .shadow(radius: 1)
                            .multilineTextAlignment(.center)
                            .scaleEffect($0 == page ? 1 : 0)
                            .opacity($0 == page ? 1 : 0)
                    }
                    
                }
                .scaleEffect(animateView ? 1 : 0)
                Spacer()
            }
            
            
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
                
                Button {
                    SoundManager.shared.play(sound: ButtonSound())
                    showInstructions = false
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
            }
            .scaleEffect(animateView ? 1 : 0)
        }
        .padding(.bottom, 100)
        .padding(.horizontal)
        .background(.regularMaterial)
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
}

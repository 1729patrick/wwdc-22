//
//  View-OilInstructionView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 15/04/22.
//

import SwiftUI

struct OilInstructionView: View {
    @Binding var showInstructions: Bool
    @State var animateView: Bool = false
    var onGo: () -> Void
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Text("1 The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(radius: 1)
                    .multilineTextAlignment(.center)
                    .scaleEffect(animateView ? 1 : 0)
                Spacer()
            }
            
            Button {
                onGo()
                showInstructions = false
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
        .background(.regularMaterial)
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
    }
}

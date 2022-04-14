//
//  View-InstructionView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 14/04/22.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(
                    width: UIScreen.screenWidth,
                    height: UIScreen.screenHeight,
                    alignment: .top
                )
                .overlay {
                    LinearGradient(
                        colors: [
                            .black.opacity(0.5),
                            .black.opacity(0.3),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
            
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Text("1/4")
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                VStack {
                    Spacer()
                    Text("The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic.")
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                        .shadow(radius: 1)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                Button {
                    SoundManager.shared.play(sound: ButtonSound())
                } label : {
                    Image("Continue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                .buttonStyle(ScaledButtonStyle())
            }
            .padding(.bottom, 100)
            .padding(.horizontal)
        }
    }
}

//
//  View-AnimalView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct AnimalView: View {
    @ObservedObject var animal: Animal
    var onSave: () -> Void
    
    var position: CGPoint {
        if animal.saved {
            return CGPoint(x: UIScreen.screenWidth - 40, y: 30)
        }
         
        return animal.getPosition()
    }
 
    var body: some View {
//        animal.path
//            .stroke(style: StrokeStyle(lineWidth: 0.4))
        
        Text("🐠")
            .font(.system(size: 70))
            .scaleEffect(animal.saved ? 0.5 : 1)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(Angle.degrees(animal.l2r ? 0 : 180), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(animal.getRotation())
            .position(position)
            .onTapGesture(perform: onSave)
            .animation(.linear(duration: 0.3), value: animal.saved)
    }
}

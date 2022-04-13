//
//  View-AnimalView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct AnimalView: View {
    @ObservedObject var animal: Animal
    
    var alwaysShowDetails: Bool
    var selected: Bool
    
    var namespace: Namespace.ID
    var spotlight: Int?
    var onSave: () -> Void
    
    @State var scale: Double = 1
    
    var position: CGPoint {
        if animal.saved {
            return CGPoint(x: UIScreen.screenWidth - 40, y: 50)
        }
         
        return animal.getPosition()
    }
    
    var rotation: Angle {
        if animal.saved || selected {
            let alpha: Double = animal.getRotation().degrees < 0 ? -1 : 1
            
            return Angle(degrees: animal.l2r ? 0 : (180 * alpha))
        }
        
        return animal.getRotation()
    }
    
    var width: Double {
        75 * animal.type.scale
    }
    
    var height: Double {
        if selected {
            return 75
        }
        
        return 75 * animal.type.scale
    }
    
    var body: some View {
//        animal.path
//            .stroke(style: StrokeStyle(lineWidth: 0.4))
//
        Image(animal.type.image)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .scaleEffect(scale)
            .spotlight(enabled: spotlight == 1 && animal.visible == false, title: "Batata")
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(Angle.degrees(animal.l2r ? 0 : 180), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(rotation)
            .matchedGeometryEffect(id: animal.id.uuidString, in: namespace)
            .position(position)
            .onTapGesture(perform: onSave)
            .animation(.linear(duration: 0.4), value: animal.saved)
            .onChange(of: animal.saved) { _ in
                if alwaysShowDetails == true {
                    scale = (UIScreen.screenWidth * 0.85) / width
                }
                
                withAnimation(.linear(duration: 0.3)) {
                    scale = 0.2
                }
            }
            
    }
}

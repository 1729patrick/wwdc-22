//
//  View-SwimmerView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct SwimmerView: View {
    @ObservedObject var swimmer: Swimmer
    
    var alwaysShowDetails: Bool
    var selected: Bool
    
    var namespace: Namespace.ID
    var specieSaved: Bool
    var onSave: () -> Void
    
    @State var scale: Double = 1
    
    var position: CGPoint {
        if swimmer.removed {
            return CGPoint(x: UIScreen.screenWidth - 100, y: 25)
        }
        
        if swimmer.saved {
            return CGPoint(x: UIScreen.screenWidth - 40, y: 25)
        }
         
        return swimmer.getPosition()
    }
    
    var rotation: Angle {
        if swimmer.saved || selected {
            let alpha: Double = swimmer.getRotation().degrees < 0 ? -1 : 1
            
            return Angle(degrees: swimmer.l2r ? 0 : (180 * alpha))
        }
        
        return swimmer.getRotation()
    }
    
    var width: Double {
        return (UIScreen.screenWidth / (UIDevice.isIPad ? 7.5 : 5.5)) * swimmer.type.scale
    }
    
    var height: Double {
        if selected {
            return (UIScreen.screenWidth / (UIDevice.isIPad ? 7.5 : 5.5))
        }
        
        return (UIScreen.screenWidth / (UIDevice.isIPad ? 7.5 : 5.5)) * swimmer.type.scale
    }
    
    var body: some View {
//        swimmer.path
//            .stroke(style: StrokeStyle(lineWidth: 0.4))

        Image(swimmer.type.image)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .scaleEffect(scale)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(Angle.degrees(swimmer.l2r ? 0 : 180), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(rotation)
            .matchedGeometryEffect(id: swimmer.id.uuidString, in: namespace)
            .position(position)
            .onTapGesture(perform: onSave)
            .animation(.linear(duration: 0.4), value: swimmer.saved)
            .animation(.linear(duration: 0.5), value: swimmer.removed)
            .onChange(of: swimmer.saved) { _ in
                if alwaysShowDetails == true && !specieSaved {
                    let alpha = UIDevice.isIPad ? 0.5 : 0.85
                    
                    scale = (UIScreen.screenWidth * alpha) / width
                }
                
                withAnimation(.linear(duration: 0.3)) {
                    scale = UIDevice.isIPad ? 0 : 0.1
                }
            }
            .onChange(of: swimmer.removed) { _ in
                withAnimation(.linear(duration: 0.3)) {
                    scale = UIDevice.isIPad ? 0 : 0.3
                }
            }
    }
}

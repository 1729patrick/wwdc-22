//
//  View-AnimalDetailView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AnimalDetailView: View {
    var animal: Animal
    let namespace: Namespace.ID
    @Binding var showDetailPage: Bool
    @Binding var alwaysShowDetails: Bool
    var id: String
    var size: Double
    
    @State var onClose: (() -> Void)?
    
    @State private var animateView: Bool = false
    @State private var animateContent: Bool = false
    @State private var scrollOffset: CGFloat = 0
    
    
    var rotation: Angle {
        if animateView {
            let alpha: Double = animal.getRotation().degrees < 0 ? -1 : 1
            
            return Angle(degrees: animal.l2r ? 0 : (180 * alpha))
        }
        
        return animal.getRotation()
    }
    
    var width: Double {
        size
    }
    
    var height: Double {
        if animateView {
            return 75
        }
        
        return size
    }
    
    var scale : Double {
        animateView ? (UIScreen.screenWidth * 0.85) / width : 1
    }
    
    var image: some View {
        VStack {
            Image(animal.type.image)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .scaleEffect(scale)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .rotation3DEffect(Angle.degrees(animal.l2r ? 0 : 180), axis: (x: 1, y: 0, z: 0))
                .rotationEffect(rotation)
                .matchedGeometryEffect(id: id, in: namespace)
        }
        .padding(.top)
        .padding(.vertical, 80)
    }
    
    var description: some View {
        VStack {
            Text(animal.type.description)
                .font(.body)
                .fontWeight(.medium)
                .shadow(color: .black, radius: 1)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
        }
        .offset(y: scrollOffset > 0 ? scrollOffset : 0)
        .opacity(animateContent ? 1 : 0)
        .scaleEffect(animateView ? 1 : 0, anchor: .top)
    }
    
    var close: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
            dismiss()
        } label : {
            Image("Close")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
        .scaleEffect(animateView ? 1 : 0)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(animal.type.id)
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .shadow(color: .black, radius: 1)
                    .lineLimit(1)
                    .scaleEffect(animateView ? 1 : 0, anchor: .leading)
                
                Spacer()
                
                close
            }
            .padding()
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    image
                    description
                        .padding()
                }
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
                .offset(offset: $scrollOffset)
            }
            .coordinateSpace(name: "SCROLL")
            .onAppear(perform: onAppear)
            .transition(.identity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thickMaterial)
    }
    
    func onAppear() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)){
            animateContent = true
        }
    }
    
    func dismiss() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            showDetailPage = false
            animateView = false
            animateContent = false
            onClose?()
        }
    }
}

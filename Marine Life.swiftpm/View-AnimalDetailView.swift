//
//  View-AnimalDetailView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AnimalDetailView: View {
    var animal: Swimmer
    let namespace: Namespace.ID
    @Binding var showingDetails: Bool
    @Binding var alwaysShowDetails: Bool
    var id: String
    var size: Double
    
    @State var onClose: (() -> Void)?
    
    @State private var animateView: Bool = false
    @State private var animateContent: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @Namespace var animation
    @State private var showMore: Bool = true
    
    @State var showingAllStatus = false
    
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
            return (UIScreen.screenWidth / (UIDevice.isIPad ? 7.5 : 5.5))
        }
        
        return size
    }
    
    var scale : Double {
        if UIDevice.isIPad {
            return animateView ? (UIScreen.screenWidth * 0.5) / width : 1
        }
        
        return animateView ? (UIScreen.screenWidth * 0.85) / width : 1
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
        .buttonStyle(ScaledButtonStyle())
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Text(animal.type.id)
                .font(.system(size: 26))
                .fontWeight(.heavy)
                .shadow(radius: 1)
                .lineLimit(1)
                .scaleEffect(animateView ? 1 : 0, anchor: .leading)
            
            Spacer()
            
            close
        }
        .padding()
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
    
    
    @ViewBuilder var description: some View {
        Text(animal.type.description)
            .font(.body)
            .fontWeight(.medium)
            .shadow(radius: 1)
            .multilineTextAlignment(.leading)
            .lineSpacing(10)
            .lineLimit(UIDevice.isIPhone && showMore ? 7 : nil)
        
        if UIDevice.isIPhone {
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        showMore.toggle()
                        SoundManager.shared.play(sound: ButtonSound())
                    }
                } label: {
                    if showMore {
                        Text("Show more")
                    } else {
                        Text("Show less")
                    }
                }
                .padding(.bottom, 10)
                
                Spacer()
            }
        }
    }
    
    func getConservationStatus(with conservationStatus: ConservationStatus)  -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                showingAllStatus.toggle()
                SoundManager.shared.play(sound: ButtonSound())
            }
        } label : {
            HStack {
                Capsule()
                    .foregroundColor(Color(conservationStatus.color))
                    .frame(width: 50, height: 30)
                
                    .overlay {
                        Text(conservationStatus.code)
                            .fontWeight(.bold)
                            .shadow(radius: 1)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(10)
                            .foregroundColor(.white)
                    }
                
                Text(conservationStatus.description)
                    .fontWeight(
                        conservationStatus == animal.type.conservationStatus ? .medium : .none)
                    .shadow(radius: 1)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(10)
                    .foregroundColor(.white)
                
                Spacer()
                
                if conservationStatus == animal.type.conservationStatus {
                    Image(systemName: showingAllStatus ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                    
                }
            }
        }
        .matchedGeometryEffect(id: conservationStatus.id, in: animation)
        .opacity(conservationStatus == animal.type.conservationStatus ? 1 : 0.3)
        .disabled(conservationStatus != animal.type.conservationStatus)
    }
    
    var conservationStatus: some View {
        VStack {
            ForEach(ConservationStatus.statusValues) { conservationStatus in
                getConservationStatus(with: conservationStatus)
            }
        }
    }
    
    var source: some View {
        HStack {
            Text("Source")
                .foregroundColor(.secondary)
            Spacer()
            Menu {
                Text("Conabio").fontWeight(.semibold) + Text(" for the list of animals in danger in Brazil")
                Text("\(animal.type.source)").fontWeight(.semibold) + Text(" for the fish description")
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                SoundManager.shared.play(sound: ButtonSound())
            }
        }
        .padding(.bottom)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    image
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Divider()
                        
                        if showingAllStatus {
                            conservationStatus
                        } else {
                            getConservationStatus(with: animal.type.conservationStatus)
                        }
                        
                        Divider()
                        
                        description
                        
                        Divider()
                        
                        Toggle(isOn: $alwaysShowDetails, label: {
                            Text("Always show details for new species")
                                .font(.body)
                                .fontWeight(.medium)
                                .shadow(radius: 1)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(10)
                        })
                        .onChange(of: alwaysShowDetails) { _ in
                            SoundManager.shared.play(sound: ButtonSound())
                        }
                        
                        Divider()
                        
                        source
                    }
                    .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                    .opacity(animateContent ? 1 : 0)
                    .scaleEffect(animateView ? 1 : 0, anchor: .top)
                    
                }
                
                .padding(.horizontal)
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
                .offset(offset: $scrollOffset)
            }
            .coordinateSpace(name: "SCROLL")
         
        }
        .onAppear(perform: onAppear)
        .transition(.identity)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
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
            showingDetails = false
            animateView = false
            animateContent = false
            onClose?()
        }
    }
}

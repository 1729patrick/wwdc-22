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
    @Namespace var animation
    @State private var showMore: Bool = true
    
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
    
    @State var showAllStatus = false
    
    let status = ["EX", "EW", "CR", "EN", "VU", "NT", "LC", "DD"]
    
    let descriptions = [
        "EX": "Extinct",
        "EW": "Extinct in the Wild",
        "CR": "Critically Endangered",
        "EN": "Endangered",
        "VU": "Vulnerable",
        "NT": "Near Threatened",
        "LC": "Least Concern",
        "DD": "Data Deficient"
    ]
    
    let colors: [String: Color] = [
        "EX": .black,
        "EW": Color("Midnight"),
        "CR": .red,
        "EN": .orange,
        "VU": .yellow,
        "NT": Color("Teal"),
        "LC": Color("Green"),
        "DD": .blue
    ]
    
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
                .font(.system(size: 32))
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
            .lineLimit(showMore ? 7 : nil)
        
        HStack {
            Spacer()
            
            Button {
                withAnimation {
                    showMore.toggle()
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
    
    func getConservationStatus(status: String)  -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                showAllStatus.toggle()
            }
        } label : {
            HStack {
                Capsule()
                    .foregroundColor(colors[status])
                    .frame(width: 50, height: 30)
                
                    .overlay {
                        Text(status)
                            .fontWeight(.bold)
                            .shadow(radius: 1)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(10)
                            .foregroundColor(.white)
                    }
                
                Text(descriptions[status] ?? "")
                    .fontWeight(
                        status == animal.type.conservationStatus ? .medium : .none)
                    .shadow(radius: 1)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(10)
                    .foregroundColor(.white)
                
                Spacer()
                
                if status == animal.type.conservationStatus {
                    Image(systemName: showAllStatus ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                    
                }
            }
        }
        .matchedGeometryEffect(id: status, in: animation)
        .opacity(status == animal.type.conservationStatus ? 1 : 0.3)
        .disabled(status != animal.type.conservationStatus)
    }
    
    var conservationStatus: some View {
        VStack {
            ForEach(0..<status.count, id: \.self) { index in
                getConservationStatus(status: status[index])
            }
        }
    }
    
    var source: some View {
        HStack {
            Text("Source")
                .foregroundColor(.secondary)
            Spacer()
            Menu {
                Text("Chosic").fontWeight(.semibold) + Text(" and ") + Text("Mixkit").fontWeight(.semibold) + Text(" for the sounds effects")
                Text("Conabio").fontWeight(.semibold) + Text(" for the list of animals in danger in Brazil")
                Text("\(animal.type.source)").fontWeight(.semibold) + Text(" for the fish description")
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
        }
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
                        
                        if showAllStatus {
                            conservationStatus
                        } else {
                            getConservationStatus(status: animal.type.conservationStatus)
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
            showDetailPage = false
            animateView = false
            animateContent = false
            onClose?()
        }
    }
}

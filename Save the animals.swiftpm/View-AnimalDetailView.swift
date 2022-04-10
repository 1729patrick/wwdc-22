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
    var id: String?
    
    @State var onClose: (() -> Void)?
    @AppStorage("showDetails") var showDetails: Bool = true
    
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    var image: some View {
        VStack {
            Text("🐠")
                .font(.system(size: 70))
                .scaleEffect(animateView ? 3 : 1)
                .matchedGeometryEffect(id: id ?? animal.id.uuidString, in: namespace)
        }
        .padding(.top)
        .padding(.vertical, 80)
    }
    
    var description: some View {
        VStack {
            Text(dummyText)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .padding(.bottom,20)
            
            Divider()
            
            Toggle("Always shows details to new species", isOn: $showDetails)
            
        }
        .padding()
        .offset(y: scrollOffset > 0 ? scrollOffset : 0)
        .opacity(animateContent ? 1 : 0)
        .scaleEffect(animateView ? 1 : 0,anchor: .top)
    }
    
    var close: some View {
        Button {
            dismiss()
        } label : {
            CloseButton()
        }
        .padding()
        .offset(y: -10)
        .opacity(animateView ? 1 : 0)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                image
                description
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .background(.thickMaterial)
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing, content: {
            close
        })
        .onAppear(perform: onAppear)
        .transition(.identity)
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
            animateView = false
            animateContent = false
            showDetailPage = false
            onClose?()
        }
    }
}





var dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."


//
//  View-HomeView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    @State var showDetailPage: Bool = false
    @State var currentAnimal: Animal?
    @Namespace var animation
    
    //    to refactor
    @State var albumScale: Double = 1
    var albumPosition: CGPoint {
        return CGPoint(x: UIScreen.screenWidth - 40, y: 30)
    }
    
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    @State var showDetails = true
    
    func scaleWorld() {
        withAnimation(.linear(duration: 0.3).delay(0.1)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.3).delay(0.3)) {
            albumScale = 1
        }
    }
    
    var savedAnimals: [Animal] {
        viewModel.animals.filter { $0.saved == true }
    }
    
    func saveAnimal(animal: Animal) {
        viewModel.save(animal: animal)
    }
    
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack(alignment: .bottom) {
                OceanWaveView(progress: progress, waveHeight: 0.01, offset: startAnimation)
                    .fill(LinearGradient(
                        colors: [Color("Light Blue"), Color("Dark Blue")],
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                    .overlay {
                        VStack {
                            Spacer()
                            SandWaveView(
                                progress: progress,
                                waveHeight: 0.01,
                                offset: startAnimation
                            )
                            .fill(LinearGradient(
                                colors: [Color("Light Gold"), Color("Dark Gold")],
                                startPoint: .top,
                                endPoint: .bottom)
                            )
                            .overlay {
                                SandPlantsView(size: size)
                            }
                            .frame(width: size.width, height: 250)
                        }
                        
                        ForEach(viewModel.animalsVisible) { animal in
                                AnimalView(animal: animal, namespace: animation) {
                                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                                    
//                                    withAnimation(.linear(duration: 10)) {
                                        currentAnimal = animal
                                        showDetailPage = true
                                    }
                                    saveAnimal(animal: animal)
                                }
                        }
                        WaterDropsView()
                    }
                    .frame(width: size.width, height: size.height)
                
                Text("🌎")
                    .font(.system(size: 50))
                    .scaleEffect(albumScale)
                    .position(albumPosition)
            }
            .onAppear {
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
                    startAnimation = size.width - 70
                }
            }
        }
        .background(.black)
        .ignoresSafeArea(.container, edges: .bottom)
        .overlay {
            if let animal = currentAnimal, showDetailPage{
                DetailView(animal: animal)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
    }
    
    
    func DetailView(animal: Animal)-> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                VStack {
                    Text("🐠")
                        .font(.system(size: 70))
                        .scaleEffect(animateView ? 3 : 1)
                        .matchedGeometryEffect(id: animal.id, in: animation)
                }
                .padding(.top, safeArea().top)
                .padding(.top, 100)
                .padding(.bottom, 60)
                
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
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
            
        }
        .background(.thinMaterial)
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing, content: {
            Button {
                // Closing View
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)){
                    currentAnimal = nil
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top,safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                animateView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)){
                animateContent = true
            }
        }
        .transition(.identity)
    }
}



var dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."



// Safe Area Value
extension View{
    func safeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
    
    // MARK: ScrollView Offset
    func offset(offset: Binding<CGFloat>)->some View{
        return self
            .overlay {
                GeometryReader{proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    offset.wrappedValue = value
                }
            }
    }
}

// MARK: Offset Key
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//
//  Extension-Onboarding.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 11/04/22.
//

import SwiftUI

extension View {
    func spotlight(enabled: Bool,title: String = "") -> some View{
        return self
            .overlay (
                ZStack{
                    if enabled {
                        GeometryReader{proxy in
                            let rect = proxy.frame(in: .global)
                            
                            SpotlightView(rect: rect,title: title) {
                                self
                            }
                        }
                    }
                }
            )
    }
    
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

struct SpotlightView<Content: View>: View {
    var content: Content
    var rect: CGRect
    var title: String
    
    init(rect: CGRect, title: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.title = title
        self.rect = rect
    }
    
    @State var tag: Int = 1009
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        Rectangle()
        // If you want to avoid user interaction
            .fill(.white.opacity(0.02))
            .onAppear {
                addOverlayView()
            }
            .onDisappear {
                removeOverlay()
            }
    }

    func removeOverlay() {
        rootController().view.subviews.forEach { view in
            if view.tag == self.tag {
                view.removeFromSuperview()
            }
        }
    }
    
    func addOverlayView(){
        let hostingView = UIHostingController(rootView: overlaySwiftUIView())
        hostingView.view.frame = screenBounds()
        hostingView.view.backgroundColor = .clear
        
        if self.tag == 1009 {
            self.tag = generateRandom()
        }
        
        hostingView.view.tag = self.tag
        
        rootController().view.subviews.forEach { view in
            if view.tag == self.tag{return}
        }
        
        rootController().view.addSubview(hostingView.view)
    }
    
    @ViewBuilder
    func overlaySwiftUIView() -> some View {
        ZStack {
            Rectangle()
                .fill(
                    Color("Midnight").opacity(0.95)
                )
                .mask(
                    ZStack {
                        let radius = (rect.height / rect.width) > 0.7 ? rect.width : 6
                        
                        Rectangle()
                            .overlay (
                                content
                                    .frame(width: rect.width, height: rect.height)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: radius))
                                    .position()
                                    .offset(x: rect.midX, y: rect.midY)
                                    .blendMode(.destinationOut)
                            )
                    }
                )
            
            if title != "" {
                HStack {
//                    Text("🐡")
//                        .font(.system(size: 140))
//                       
                    Text(title)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        
                        .padding()
                        .lineLimit(2)
                }
                .offset(
                    x: screenBounds().midX,
                    y: rect.maxY > (screenBounds().height - 150) ? (rect.minY - 150) : (rect.maxY + 150))
                .position()
               
            }
        }
        .frame(width: screenBounds().width, height: screenBounds().height)
        .ignoresSafeArea()
    }

    func generateRandom() -> Int {
        let random = Int(UUID().uuid.0)

        let subViews = rootController().view.subviews
        
        for index in subViews.indices {
            if subViews[index].tag == random{
                return generateRandom()
            }
        }
        
        return random
    }
}

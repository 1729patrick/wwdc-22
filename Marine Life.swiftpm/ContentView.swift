//
//  ContentView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var startAnimation: CGFloat = 0
    
    @State private var animateView: Bool = false
    
    //    animal details
    @State var showDetailPage: Bool = false
    @State var currentAnimal: Animal?
    @State var showingAlbum: Bool = false
    
    @Namespace var animation
    
    @State var oilSpill: Bool = false
    @State var showOilSpillInstructions: Bool = false
    @State var showOilResult: Bool = false
    
    //    album icon
    @State var albumScale: Double = 1
    @State var trashScale: Double = 1
    
    @AppStorage("showInstructions") var showInstructions: Bool = true
    
    @State var showLevelInstructions: Bool = false
    
    @State var level: Int = 0
    @State private var phase = 0.0
    
    var animals: some View {
        ForEach(viewModel.animals) { animal in
            AnimalView(
                animal: animal,
                alwaysShowDetails: viewModel.alwaysShowDetails,
                selected: showDetailPage && currentAnimal == animal,
                namespace: animation,
                specieSaved: viewModel.animalsSaved[animal.type] ?? 0 > 0
            ) {
                SoundManager.shared.play(sound: FishSound())
                selectAnimal(with: animal)
            }
        }
    }
    
    var trash: some View {
        Image("Trash")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .overlay(alignment: .bottomLeading) {
                if viewModel.trashesRemovedCount > 0 {
                        Text("\(viewModel.trashesRemovedCount)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(.white)
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                }
            }
            .scaleEffect(animateView ? 1 : 0)
            .scaleEffect(trashScale)
    }
    
    var album: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
            showingAlbum = true
        } label: {
            Image("Aquarium")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
        .buttonStyle(ScaledButtonStyle())
        .overlay(alignment: .bottomLeading) {
            if viewModel.level == 6 {
                    Text("\(viewModel.animalsSavedCount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(.white)
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
            }
        }
        .scaleEffect(albumScale)
        .scaleEffect(animateView ? 1 : 0)
    }
    
    
    var levelTitle: some View {
        var title = ""
        
        switch level {
        case 1:
            title = "Save the animals"
        case 2:
            title = "Run against the oil spill"
        case 3:
            title = "Feed your fish"
        case 4:
            title = "Keep the ocean clean"
        case 5:
            title = "Save all species"
        default:
            title = ""
        }
        
        return HStack {
            ZStack {
                Image("Button")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                
                VStack(spacing: 0) {
                    Text(viewModel.level == 5 ? "LAST" : "\(viewModel.level)")
                        .font(.system(size: viewModel.level == 5 ? 8 : 22))
                        .fontWeight(.heavy)
                        .shadow(radius: 1)
                        .foregroundColor(.white)
                    
                    Text("LEVEL")
                        .font(.system(size: 8))
                        .fontWeight(.heavy)
                        .shadow(radius: 1)
                        .foregroundColor(.white)
                        .padding(.top, -2)
                }
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .shadow(radius: 1)
            }
        }
    }
    
    var header: some View {
        HStack {
            if viewModel.level <= 5 {
                levelTitle
            }
            
            Spacer()
            if level >= 4 {
                trash
            }
            album
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                let size = proxy.size
                
                
                ZStack(alignment: .bottom) {
                    Image(UIDevice.isIPad ? "BackgroundPad" : "Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(
                            width: size.width,
                            height: size.height,
                            alignment: .top
                        )
                        .overlay {
                            LinearGradient(
                                colors: [
                                    .black.opacity(0.3),
                                    .black.opacity(0),
                                    .black.opacity(0),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea()
                        }
                    WaveView(strength: 10, frequency: 5, start: 0.35, phase: phase)
                        .fill(
                            LinearGradient(
                                colors: oilSpill ?
                                [
                                    .black.opacity(0.7),
                                    .black.opacity(0.8),
                                ]
                                :
                                    [
                                        Color("Light Blue").opacity(0.7),
                                        Color("Dark Blue").opacity(0.8),
                                    ],
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: size.width, height: size.height)
                        .overlay {
                            getSand(size: size)
                            WaterDropsView()

                            animals
                        }
                    
                        .onTapGesture {
                            SoundManager.shared.play(sound: WrongSound())
                        }
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            
            header
            
            if showingAlbum {
                AlbumView(
                    showingAlbum: $showingAlbum,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    timeToFeedAgain: viewModel.timeToFeedAgain,
                    feed: viewModel.feed,
                    animalsSaved: viewModel.animalsSaved,
                    speciesSavedCount: viewModel.speciesSavedCount,
                    level: viewModel.level
                )
            }
            
            if let animal = currentAnimal, showDetailPage {
                AnimalDetailView(
                    animal: animal,
                    namespace: animation,
                    showDetailPage: $showDetailPage,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    id: animal.id.uuidString,
                    size: (UIScreen.screenWidth / 5.5) * animal.type.scale,
                    onClose: {
                        saveAnimal(animal: animal)
                        currentAnimal = nil
                    }
                )
            }
            
            if showInstructions {
                InstructionView() {
                    showInstructions = false
                    viewModel.nextLevel()
                }
            }
            
            if showLevelInstructions {
                LevelInstructionView(level: viewModel.level, animalsSavedCount: viewModel.animalsSavedCount) {
                    showLevelInstructions = false
                }
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: viewModel.level) { level in
            if level == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    startLevel2()
                    showLevelInstructions = true
                }
            } else if level == 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    startLevel3()
                    showLevelInstructions = true
                }
            } else if level == 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    self.level = level
                    showLevelInstructions = true
                    startLevelWithTrash()
                }
            } else if level == 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    showLevelInstructions = true
                    startLevelWithTrash()
                }
            }else {
                self.level = level
                showLevelInstructions = true
            }
        }
    }
    
    func onAppear() {
        level = viewModel.level
        
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
               self.phase = .pi * 2
           }
        
//        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
//            startAnimation = UIScreen.screenWidth
//        }
        
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
        
        if level == 2 {
            startLevel2()
        } else if level >= 4 {
            startLevelWithTrash()
        }
    }
    
    func startLevel2() {
        oilSpill.toggle()
        
        SoundManager.shared.play(sound: OilSpillSound())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            SoundManager.shared.pause(sound: BackgroundSound())
        }
    }
    
    
    func startLevel3() {
        oilSpill.toggle()
        
        SoundManager.shared.stop(sound: OilSpillSound())
        SoundManager.shared.resume(sound: BackgroundSound())
    }
    
    func startLevelWithTrash() {
        viewModel.addTrashes()
    }
    
    func getSand(size: CGSize) -> some View {
        VStack {
            Spacer()
            WaveView(strength: 3, frequency: 5, start: 0, phase: phase)
            .fill(LinearGradient(
                colors: [Color("Light Gold"), Color("Dark Gold")],
                startPoint: .top,
                endPoint: .bottom)
            )
            .overlay {
                SandPlantsView(size: size)
            }
            .frame(width: size.width, height: 150)
        }
    }
    
    func selectAnimal(with animal: Animal) {
        if animal.type.type == "trash" {
            removeTrash(animal: animal)
        } else {
            
            if viewModel.alwaysShowDetails == true && !(viewModel.animalsSaved[animal.type] ?? 0 > 0) {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                    currentAnimal = animal
                    showDetailPage = true
                }
            }  else {
                saveAnimal(animal: animal)
            }
        }
    }
    
    func saveAnimal(animal: Animal) {
        viewModel.save(animal: animal)
        scaleAlbum()
    }
    
    func removeTrash(animal: Animal) {
        viewModel.remove(animal: animal)
        scaleTrash()
    }
    
    func scaleAlbum() {
        withAnimation(.linear(duration: 0.2).delay(0.25)) {
            albumScale = 1.3
        }
        withAnimation(.linear(duration: 0.15).delay(0.5)) {
            albumScale = 1
        }
    }
    
    func scaleTrash() {
        withAnimation(.linear(duration: 0.2).delay(0.35)) {
            trashScale = 1.3
        }
        withAnimation(.linear(duration: 0.15).delay(0.7)) {
            trashScale = 1
        }
    }
}

//
//  ContentView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private var animateView: Bool = false
    
    //    animal details
    @State var showingDetails: Bool = false
    @State var currentSwimmer: Swimmer?
    @State var showingAquariumList: Bool = false
    
    @Namespace var animation
    
    @State var oilSpill: Bool = false
    
    //    icons scale
    @State var aquariumScale: Double = 1
    @State var trashScale: Double = 1
    
    @AppStorage("showingInstructions") var showingInstructions: Bool = true
    
    @State var showingLevelInstructions: Bool = false
    
    @State var level: Int = 0
    @State private var wave = 0.0
    
    @State private var impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var swimmers: some View {
        ForEach(viewModel.swimmers) { swimmer in
            SwimmerView(
                swimmer: swimmer,
                alwaysShowDetails: viewModel.alwaysShowDetails,
                selected: showingDetails && currentSwimmer == swimmer,
                namespace: animation,
                specieSaved: viewModel.isSpecieSaved(swimmer.type)
            ) {
                SoundManager.shared.play(sound: SwimmerSound())
                selectAnimal(with: swimmer)
            }
        }
    }
    
    var trash: some View {
        Button {
            SoundManager.shared.play(sound: WrongSound())
            impactFeedback.impactOccurred()
        } label: {
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
    }
    
    var aquarium: some View {
        Button {
            SoundManager.shared.play(sound: ButtonSound())
            showingAquariumList = true
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
        .scaleEffect(aquariumScale)
        .scaleEffect(animateView ? 1 : 0)
    }
    
    
    var levelTitle: some View {
        var title = ""
        
        switch level {
        case 1:
            title = "Save the fish"
        case 2:
            title = "Run against oil spill"
        case 3:
            title = "Feed your fish"
        case 4:
            title = "Keep the ocean clean"
        case 5:
            title = "Save all species"
        default:
            title = "Marine Life"
        }
        
        return HStack {
            if viewModel.level <= 5 {
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
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .shadow(radius: 1)
                    .lineLimit(1)
            }
        }
    }
    
    var header: some View {
        HStack {
            levelTitle
            
            Spacer()
            if level >= 4 {
                trash
            }
            aquarium
        }
        .padding()
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
                    WaveView(strength: 10, frequency: 5, start: 0.35, phase: wave)
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
                            
                            swimmers
                        }
                    
                        .onTapGesture {
                            SoundManager.shared.play(sound: WrongSound())
                            impactFeedback.impactOccurred()
                        }
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            
            header
            
            if showingAquariumList {
                AquariumListView(
                    showingAquariumList: $showingAquariumList,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    timeToFeedAgain: viewModel.timeToFeedAgain,
                    feed: viewModel.feed,
                    isSpecieSaved: viewModel.isSpecieSaved,
                    getSpeciesSaved: viewModel.getSpeciesSaved,
                    speciesSavedCount: viewModel.speciesSavedCount,
                    level: viewModel.level
                )
            }
            
            if let animal = currentSwimmer, showingDetails {
                AnimalDetailView(
                    animal: animal,
                    namespace: animation,
                    showingDetails: $showingDetails,
                    alwaysShowDetails: $viewModel.alwaysShowDetails,
                    id: animal.id.uuidString,
                    size: (UIScreen.screenWidth / (UIDevice.isIPad ? 7.5 : 5.5)) * animal.type.scale,
                    onClose: {
                        saveAnimal(animal: animal)
                        currentSwimmer = nil
                    }
                )
            }
            
            if showingInstructions {
                InstructionView() {
                    showingInstructions = false
                    viewModel.nextLevel()
                }
            }
            
            if showingLevelInstructions {
                LevelInstructionView(level: viewModel.level, animalsSavedCount: viewModel.animalsSavedCount) {
                    showingLevelInstructions = false
                }
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: viewModel.level) { level in
            if level == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    startLevel2()
                    showingLevelInstructions = true
                }
            } else if level == 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    startLevel3()
                    showingLevelInstructions = true
                }
            } else if level == 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    self.level = level
                    showingLevelInstructions = true
                    startLevelWithTrash()
                }
            } else if level == 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    showingLevelInstructions = true
                }
            } else if level == 6 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.level = level
                    showingLevelInstructions = true
                    playInspiringSong()
                }
            } else {
                self.level = level
                showingLevelInstructions = true
            }
        }
    }
    
    func onAppear() {
        level = viewModel.level
        
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            self.wave = .pi * 2
        }
        
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            animateView = true
        }
        
        if level == 2 {
            startLevel2()
        } else if level >= 4 {
            startLevelWithTrash()
        }
    }
    
    func playInspiringSong() {
        SoundManager.shared.stop(sound: BackgroundSound())
        SoundManager.shared.play(sound: InspiringSound())
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
            WaveView(strength: 3, frequency: 5, start: 0, phase: wave)
                .fill(LinearGradient(
                    colors: [Color("Light Gold"), Color("Dark Gold")],
                    startPoint: .top,
                    endPoint: .bottom)
                )
                .overlay {
                    SandPlantsView(size: size)
                }
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                .frame(width: size.width, height: UIScreen.screenHeight * 0.15)
        }
    }
    
    func selectAnimal(with swimmer: Swimmer) {
        if swimmer.type.type == .trash {
            removeTrash(trash: swimmer)
            return
        }
        
        if viewModel.alwaysShowDetails == true && viewModel.isSpecieSaved(swimmer.type) == false {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                currentSwimmer = swimmer
                showingDetails = true
            }
        }  else {
            saveAnimal(animal: swimmer)
        }
        
    }
    
    func saveAnimal(animal: Swimmer) {
        viewModel.save(animal: animal)
        scaleAlbum()
    }
    
    func removeTrash(trash: Swimmer) {
        viewModel.remove(trash: trash)
        scaleTrash()
    }
    
    func scaleAlbum() {
        withAnimation(.linear(duration: 0.2).delay(0.45)) {
            aquariumScale = 1.3
        }
        withAnimation(.linear(duration: 0.15).delay(0.7)) {
            aquariumScale = 1
        }
    }
    
    func scaleTrash() {
        withAnimation(.linear(duration: 0.2).delay(0.55)) {
            trashScale = 1.3
        }
        withAnimation(.linear(duration: 0.15).delay(0.9)) {
            trashScale = 1
        }
    }
}

//
//  ViewModel.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

class ViewModel: ObservableObject, Identifiable {
    let maxAnimals = 10
    
    var maxTrashes: Int {
        level == 4 ? 8 : 4
    }
    
    @Published var swimmers = [Swimmer]()
    @Published var swimmersSaved = [SwimmerType:Int]()
    
    @AppStorage("alwaysShowDetails") var alwaysShowDetails: Bool = true
    @AppStorage("swimmersSaved") var saved: Data = Data()
    
    @AppStorage("timeToFeedAgain") var timeToFeedAgain: Int = .zero
    
    @AppStorage("level") var level: Int = 0
    @AppStorage("trashesRemovedCount") var trashesRemovedCount: Int = 0
    
    var animalsSavedCount: Int {
        let keys = swimmersSaved.keys.filter { $0.type == .animal}
        
        return keys.reduce(into: 0) { totalCount, type in
            totalCount += swimmersSaved[type] ?? 0
        }
    }
    
    var speciesSavedCount: Int {
        return swimmersSaved.keys.filter { $0.type == .animal}.count
    }
    
    var animalsVisible: [Swimmer] {
        swimmers.filter { $0.type.type == .animal && $0.visible }
    }
    
    var trashesVisible: [Swimmer] {
        swimmers.filter { $0.type.type == .trash && $0.visible }
    }
    
    var nextAnimalIndex: Int {
        let animals = swimmers.filter { $0.type.type == .animal }
        
        if animals.count < SwimmerType.animals.count {
            return animals.count
        }
        
        return animals.count % SwimmerType.animals.count
    }
    
    var nextTrashIndex: Int {
        let trash = swimmers.filter { $0.type.type == .trash }
        
        if trash.count < SwimmerType.trashes.count {
            return trash.count
        }
        
        return trash.count % SwimmerType.trashes.count
    }
    
    init() {
        setup()
        decodeSavedAnimals()
        executeFeedTimer()
    }
    
    func decodeSavedAnimals() {
        guard let swimmersSaved = try? JSONDecoder().decode([SwimmerType:Int].self, from: saved) else { return }
        
        self.swimmersSaved = swimmersSaved
    }
    
    func encodeSavedAnimals() {
        guard let saved = try? JSONEncoder().encode(swimmersSaved) else { return }
        self.saved = saved
    }
    
    func addSwimmer(type: SwimmerType.Types, starting: Bool = false) {
        if type == .animal {
            guard animalsVisible.count < maxAnimals else {
                return
            }
        }
        
        if type == .trash {
            guard trashesVisible.count < maxTrashes else {
                return
            }
        }
        
        let yRange: ClosedRange<Double> = UIScreen.screenHeight * 0.35...UIScreen.screenHeight
        
        let startLeft = Bool.random()
        
        let minWidth: Double = UIDevice.isIPad ? -Swimmer.maxAnimalWidth : -Swimmer.maxAnimalWidth / 2
        let maxWidth: Double = UIScreen.screenWidth + CGFloat(abs(minWidth))
        
        var from: CGPoint {
            let y = Double.random(in: yRange)
            
            return .init(x: startLeft ? minWidth : maxWidth, y: y)
        }
        
        var to: CGPoint {
            let y = Double.random(in: yRange)
            
            return .init(x: startLeft ? maxWidth : minWidth, y: y)
        }
        
        let midWidth = Double.random(in: 0...UIScreen.screenWidth / 2)
        
        let xRangeLeft2Right: ClosedRange<Double> = 0...midWidth
        let xRangeRight2Left: ClosedRange<Double> = midWidth...UIScreen.screenWidth
        
        var control1: CGPoint {
            let y = Double.random(in: yRange)
            let x = Double.random(in: startLeft ? xRangeLeft2Right : xRangeRight2Left)
            
            return .init(x: x, y: y)
        }
        
        var control2: CGPoint {
            let y = Double.random(in: yRange)
            let x = Double.random(in: startLeft ? xRangeRight2Left : xRangeLeft2Right)
            
            return .init(x: x, y: y)
        }
        
        var animalType: SwimmerType = SwimmerType.animals[nextAnimalIndex]
        
        if type == .trash {
            animalType = SwimmerType.trashes[nextTrashIndex]
        }
        
        let swimmer = Swimmer(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft,
            type: animalType,
            starting: starting,
            onDestroy: {
                self.addSwimmer(type: type)
            }
        )
        
        swimmers.append(swimmer)
    }
    
    func setup() {
        self.addSwimmer(type: .animal, starting: true)
        self.addSwimmer(type: .animal, starting: true)
        self.addSwimmer(type: .animal, starting: true)
        self.addSwimmer(type: .animal, starting: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.animalsVisible.count > self.maxAnimals {
                timer.invalidate()
            } else {
                self.addSwimmer(type: .animal)
            }
        }
    }
    
    func save(animal: Swimmer) {
        animal.save()
        self.addSwimmer(type: .animal)
        
        incrementSavedCount(type: animal.type)
        
        if level == 1 && animalsSavedCount == 4 {
            nextLevel()
        } else if level == 2 && animalsSavedCount == 10 {
            nextLevel()
        } else if level == 5 && speciesSavedCount == SwimmerType.animals.count {    
            nextLevel()
        }
    }
    
    func remove(trash: Swimmer) {
        trash.remove()
        self.addSwimmer(type: .trash)
        
        trashesRemovedCount += 1
        
        if trashesRemovedCount == 13 {
            nextLevel()
            
            if speciesSavedCount == SwimmerType.animals.count {
                nextLevel()
            }
        }
    }
    
    func incrementSavedCount(type: SwimmerType) {
        let savedCount = swimmersSaved[type] ?? 0
        swimmersSaved[type] = savedCount + 1
        
        encodeSavedAnimals()
    }
    
    private func executeFeedTimer() {
        guard timeToFeedAgain > 0 else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timeToFeedAgain -= 1
            self.executeFeedTimer()
        }
    }
    
    func feed() {
        timeToFeedAgain = 59
        executeFeedTimer()
        
        if level == 3 {
            nextLevel()
        }
    }
    
    func nextLevel() {
        level += 1
    }
    
    func addTrashes() {
        self.addSwimmer(type: .trash, starting: true)
        self.addSwimmer(type: .trash, starting: true)
        self.addSwimmer(type: .trash, starting: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.trashesVisible.count > self.maxTrashes {
                timer.invalidate()
            } else {
                self.addSwimmer(type: .trash)
            }
        }
    }
    
    func isSpecieSaved(_ type: SwimmerType)-> Bool {
        getSpeciesSaved(type) > 0
    }
    
    func getSpeciesSaved(_ type: SwimmerType)-> Int {
        swimmersSaved[type] ?? 0
    }
}

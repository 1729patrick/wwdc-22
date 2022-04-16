//
//  ViewModel.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

class ViewModel: ObservableObject, Identifiable {
    let maxAnimals = 12
    let maxTrashes = 12
    
    @Published var animals = [Animal]()
    @Published var animalsSaved = [AnimalType:Int]()
    
    @AppStorage("alwaysShowDetails") var alwaysShowDetails: Bool = true
    @AppStorage("animalsSaved") var saved: Data = Data()
    
    @AppStorage("timeToFeedAgain") var timeToFeedAgain: Int = .zero
    
    @AppStorage("level") var level: Int = 0
    
    var animalsSavedCount: Int {
        let keys = animalsSaved.keys.filter { $0.type == "animal"}
        
       return keys.reduce(into: 0) { totalCount, type in
           totalCount += animalsSaved[type] ?? 0
        }
    }
  
    var trashesRemovedCount: Int {
        return animalsSaved.keys.filter { $0.type == "trash"}.count
    }
    
    var speciesSavedCount: Int {
        return animalsSaved.keys.filter { $0.type == "animal"}.count
    }
    
    var animalsVisible: [Animal] {
        animals.filter { $0.type.type == "animal" && $0.visible }
    }
    
    var trashesVisible: [Animal] {
        animals.filter { $0.type.type == "trash" && $0.visible }
    }
    
    var nextAnimalIndex: Int {
        let animals = animals.filter { $0.type.type == "animal" }
        
        if animals.count < AnimalType.animals.count {
            return animals.count
        }
        
        return animals.count % AnimalType.animals.count
    }
    
    var nextTrashIndex: Int {
        let trash = animals.filter { $0.type.type == "trash" }
        
        if trash.count < AnimalType.trashes.count {
            return trash.count
        }
        
        return trash.count % AnimalType.trashes.count
    }
    
    init() {
        setup()
        decodeSavedAnimals()
        executeFeedTimer()
    }
    
    func decodeSavedAnimals() {
        guard let animalsSaved = try? JSONDecoder().decode([AnimalType:Int].self, from: saved) else { return }
        
        self.animalsSaved = animalsSaved
    }
    
    func encodeSavedAnimals() {
        guard let saved = try? JSONEncoder().encode(animalsSaved) else { return }
        self.saved = saved
    }
    
    func addAnimal(type: String) {
        guard animalsVisible.count < maxAnimals else {
            return
        }
        
        guard trashesVisible.count < maxTrashes else {
            return
        }
        
        let yRange: ClosedRange<Double> = UIScreen.screenHeight * 0.35...UIScreen.screenHeight
        
        let startLeft = Bool.random()
        let minWidth: Double = -100
        let maxWidth: Double = UIScreen.screenWidth + CGFloat(100)
        
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
        
        var animalType: AnimalType = AnimalType.animals[nextAnimalIndex]
        
        if type == "trash" {
            animalType = AnimalType.trashes[nextTrashIndex]
        }
        
        let animal = Animal(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft,
            type: animalType,
            onDestroy: {
                self.addAnimal(type: type)
            }
        )
        
        animals.append(animal)
    }
    
    func setup() {
        self.addAnimal(type: "animal")
        self.addAnimal(type: "animal")
        self.addAnimal(type: "animal")
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.animalsVisible.count >= self.maxAnimals {
                timer.invalidate()
            } else {
                self.addAnimal(type: "animal")
            }
        }
    }
    
    func save(animal: Animal) {
        animal.save()
        self.addAnimal(type: "animal")
        
        incrementSavedCount(type: animal.type)
        
        if level == 1 && animalsSavedCount == 3 {
            nextLevel()
        } else if level == 2 && animalsSavedCount == 7 {
            nextLevel()
        }
    }
    
    func remove(animal: Animal) {
        animal.remove()
        self.addAnimal(type: "trash")
        
        if trashesRemovedCount == 13 {
            nextLevel()
        }
    }
 
    func incrementSavedCount(type: AnimalType) {
        let savedCount = animalsSaved[type] ?? 0
        animalsSaved[type] = savedCount + 1
        
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
        nextLevel()
    }
    
    func nextLevel() {
        level += 1
    }
    
    func addTrashes() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.trashesVisible.count >= self.maxTrashes {
                timer.invalidate()
            } else {
                self.addAnimal(type: "trash")
            }
        }
    }
}

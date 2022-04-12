//
//  ViewModel.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

class ViewModel: ObservableObject, Identifiable {
    let maxAnimals = 6
    @Published var animals = [Animal]()
    var l2r = 0
    var r2l = 0
    
    var animalsVisible: [Animal] {
        animals.filter { $0.visible }
    }
    
    var animalsSaved: [Animal] {
        animals.filter { $0.saved }
    }
    
    func addAnimal() {
        if animalsVisible.count >= maxAnimals {
            return
        }
        
        let yRange: ClosedRange<Double> = UIScreen.screenHeight * 0.25...UIScreen.screenHeight
        
        let startLeft = Bool.random()
        
        if startLeft {
            l2r += 1
        } else {
            r2l += 1
        }
        
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
        
        struct AnimalType {
            let image: String
            let speed: Double
        }
        
        let animalTypes = [
            AnimalType(image: "Atlantirivulus nudiventris", speed: 600),
            AnimalType(image: "Carcharhinus galapagensis", speed: 650),
            AnimalType(image: "Galeorhinus galeus", speed: 650),
            AnimalType(image: "Polyprion americanus", speed: 500),
            AnimalType(image: "Spintherobolus papilliferus", speed: 500),
            AnimalType(image: "Austrolebias cinereus", speed: 500),
            AnimalType(image: "Carcharhinus isodon", speed: 650),
            AnimalType(image: "Hypsolebias auratus", speed: 500),
            AnimalType(image: "Pontoporia blainvillei", speed: 700),
            AnimalType(image: "Cetorhinus maximus", speed: 650),
            AnimalType(image: "Leporinus guttatus", speed: 500),
            AnimalType(image: "Pristis pectinata", speed: 700),
            AnimalType(image: "Balaenoptera musculus", speed: 1500),
            AnimalType(image: "Austrolebias jaegari",  speed: 500),
            AnimalType(image: "Characidium vestigipinne", speed: 500),
            AnimalType(image: "Mustelus schmitti", speed: 650),
            AnimalType(image: "Prochilodus britskii", speed: 500),
            AnimalType(image: "Baryancistrus longipinnis", speed: 650),
            AnimalType(image: "Chelonia mydas", speed: 1700),
            AnimalType(image: "Myliobatis ridens", speed: 1500),
            AnimalType(image: "Schroederichthys bivius", speed: 550),
            AnimalType(image: "Epinephelus itajara", speed: 500),
            AnimalType(image: "Brycon vermelha", speed: 500),
            AnimalType(image: "Odontesthes bicudo", speed: 500),
            AnimalType(image: "Sphyrna lewini", speed: 650)
        ]
        
        let animalType = animalTypes.randomElement()!
        
        let animal = Animal(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft,
            speed: animalType.speed * 1.2,
            image: animalType.image,
            onDestroy: addAnimal
        )
        
        animals.append(animal)
    }
    
    init() {
        setup()
    }
    
    func setup() {
        self.addAnimal()
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            if self.animalsVisible.count >= self.maxAnimals {
                timer.invalidate()
            } else {
                self.addAnimal()
            }
        }
    }
    
    func save(animal: Animal) {
        animal.save()
        addAnimal()
    }
}

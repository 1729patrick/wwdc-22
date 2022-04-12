//
//  ViewModel.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct AnimalType {
    let image: String
    let speed: Double
    let scale: Double
    
    static var data: [AnimalType] {
        [
            AnimalType(image: "Mustelus schmitti", speed: 900, scale: 2),
            AnimalType(image: "Atlantirivulus nudiventris", speed: 600, scale: 1),
            
            AnimalType(image: "Pristis pectinata", speed: 900, scale: 1.5),
            AnimalType(image: "Polyprion americanus", speed: 600, scale: 1),
            
            AnimalType(image: "Chelonia mydas", speed: 4000, scale: 1.25),
            AnimalType(image: "Epinephelus itajara", speed: 600, scale: 1),
            
            AnimalType(image: "Balaenoptera musculus", speed: 3000, scale: 3),
            AnimalType(image: "Spintherobolus papilliferus", speed: 600, scale: 1),
            
            AnimalType(image: "Galeorhinus galeus", speed: 900, scale: 2),
            AnimalType(image: "Austrolebias cinereus", speed: 600, scale: 1),
            
            AnimalType(image: "Carcharhinus galapagensis", speed: 900, scale: 2),
            AnimalType(image: "Hypsolebias auratus", speed: 600, scale: 1),
            
            AnimalType(image: "Carcharhinus isodon", speed: 900, scale: 2),
            AnimalType(image: "Leporinus guttatus", speed: 600, scale: 1),
            
            AnimalType(image: "Pontoporia blainvillei", speed: 900, scale: 1.5),
            AnimalType(image: "Austrolebias jaegari",  speed: 600, scale: 1),

            AnimalType(image: "Characidium vestigipinne", speed: 600, scale: 1),
            AnimalType(image: "Myliobatis ridens", speed: 1500, scale: 1.25),
            
            AnimalType(image: "Prochilodus britskii", speed: 600, scale: 1),
            AnimalType(image: "Sphyrna lewini", speed: 900, scale: 2),
            
            AnimalType(image: "Schroederichthys bivius", speed: 600, scale: 1),
//            AnimalType(image: "Cetorhinus maximus", speed: 900, scale: 2),
            //            AnimalType(image: "Baryancistrus longipinnis", speed: 600, scale: 1),
                    
            
            AnimalType(image: "Brycon vermelha", speed: 600, scale: 1),
            AnimalType(image: "Odontesthes bicudo", speed: 600, scale: 1)
            ]
    }
}

class ViewModel: ObservableObject, Identifiable {
   let maxAnimals = 12
    @Published var animals = [Animal]()
    var l2r = 0
    var r2l = 0
    
    var animalsVisible: [Animal] {
        animals.filter { $0.visible }
    }
    
    var animalsSaved: [Animal] {
        animals.filter { $0.saved }
    }
    
    var nextTypeIndex: Int {
        if animals.count < AnimalType.data.count {
            return animals.count
        }
        
        return animals.count % AnimalType.data.count
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
        
        let animalType = AnimalType.data[nextTypeIndex]
        
        let animal = Animal(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft,
            speed: animalType.speed,
            image: animalType.image,
            scale: animalType.scale,
            onDestroy: addAnimal
        )
        
        animals.append(animal)
    }
    
    init() {
        setup()
    }
    
    func setup() {
        self.addAnimal()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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

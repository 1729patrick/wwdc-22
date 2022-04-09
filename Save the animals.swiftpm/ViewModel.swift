//
//  ViewModel.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

class ViewModel: ObservableObject, Identifiable {
    let maxAnimals = 10
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
        
        var yRange: ClosedRange<Double> = UIScreen.screenHeight * 0.25...UIScreen.screenHeight
        
        let startLeft = Bool.random()
        
        if startLeft {
            l2r += 1
        } else {
            r2l += 1
        }
        
        let minWidth: Double = -50
        let maxWidth: Double = UIScreen.screenWidth + CGFloat(50)
        
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
        
        yRange = UIScreen.screenHeight * 0.25...UIScreen.screenHeight * 0.9
        
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
        
        let animal = Animal(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft,
            onDestroy: addAnimal
        )
        
        animals.append(animal)
    }
    
    init() {
        setup()
    }
    
    func setup() {
        let initialAnimalsSize = 10
        
        self.addAnimal()
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            self.addAnimal()
            
            if self.animals.count >= initialAnimalsSize {
                timer.invalidate()
            }
        }
    }
    
    func save(animal: Animal) {
        animal.save()
        
        addAnimal()
    }
}

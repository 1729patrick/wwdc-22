//
//  File.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject, Identifiable {
    @Published var animals = [AnimalModel]()
    
    func addAnimal() {
        let yRange: ClosedRange<Double> = UIScreen.screenHeight * 0.26...UIScreen.screenHeight - 100
        
        let startLeft = Bool.random()
        
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
        
        let xRangeLeft2Right: ClosedRange<Double> = 0...UIScreen.screenWidth / 2
        let xRangeRight2Left: ClosedRange<Double> = UIScreen.screenWidth / 2...UIScreen.screenWidth
        
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
        
        let animal = AnimalModel(
            from: from,
            to: to,
            control1: control1,
            control2: control2,
            l2r: startLeft
        )
        
        animals.append(animal)
    }
}


class AnimalModel: Identifiable, ObservableObject {
    var id = UUID()
    
    var l2r: Bool
    var flying = false
    var alongTrackDistance = CGFloat.zero {
        didSet {
            print("AAAA")
        }
    }
    
    var timer: Cancellable? = nil
    
    let track: ParametricCurve
    let path: Path
    
    var aircraft: some View {
        let t = track.curveParameter(arcLength: alongTrackDistance)
        let p = track.point(t: t)
        let dp = track.derivate(t: t)
        let h = Angle(radians: atan2(Double(dp.dy), Double(dp.dx)))
        return Text("🐠")
            .font(.system(size: 70))
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(Angle.degrees(l2r ? 0 : 180), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(h)
            .position(p)
            
    }
    
    
    init(from: CGPoint, to: CGPoint, control1: CGPoint, control2: CGPoint, l2r: Bool) {
        track = Bezier3(from: from, to: to, control1: control1, control2: control2)
        
        path = Path({ (path) in
            path.move(to: from)
            path.addCurve(to: to, control1: control1, control2: control2)
        })
        
        self.l2r = l2r
        fly()
    }
    
    func fly() {
        flying = true
        timer = Timer
            .publish(every: 0.02, on: RunLoop.main, in: RunLoop.Mode.default)
            .autoconnect()
            .sink(receiveValue: { (_) in
                self.objectWillChange.send()
                self.alongTrackDistance += self.track.totalArcLength / 200.0
                if self.alongTrackDistance > self.track.totalArcLength {
                    self.timer?.cancel()
                    self.flying = false
                }
            })
    }
}

//
//  Model-Swimmer.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import Combine
import SwiftUI

class Swimmer: Identifiable, ObservableObject, Equatable {
    static func == (lhs: Swimmer, rhs: Swimmer) -> Bool {
        lhs.id == rhs.id
    }
    
    private(set) var id = UUID()
    private(set) var l2r: Bool
    private(set) var type: SwimmerType
    private(set) var onDestroy: (() -> Void)? = nil
    private(set) var saved: Bool = false
    private(set) var removed: Bool = false
    private(set) var visible: Bool = true
    private var alongTrackDistance = CGFloat.zero
    
    private var timer: Cancellable? = nil
    private let track: ParametricCurve
    let path: Path
 
    init(
        from: CGPoint,
        to: CGPoint,
        control1: CGPoint,
        control2: CGPoint,
        l2r: Bool,
        type: SwimmerType,
        onDestroy: (() -> Void)? = nil
    ) {
        track = Bezier3(from: from, to: to, control1: control1, control2: control2)
        
        path = Path({ (path) in
            path.move(to: from)
            path.addCurve(to: to, control1: control1, control2: control2)
        })
        
        self.l2r = l2r
        self.onDestroy = onDestroy
        self.type = type
        
        startSwimming()
    }
    
    func getPosition() -> CGPoint {
        let t = track.curveParameter(arcLength: alongTrackDistance)
        let p = track.point(t: t)

        return p
    }
    
    func getRotation() -> Angle {
        let t = track.curveParameter(arcLength: alongTrackDistance)
        let dp = track.derivate(t: t)
        let h = Angle(radians: atan2(Double(dp.dy), Double(dp.dx)))

        return h
    }
    
    func startSwimming() {
        timer = Timer
            .publish(every: 0.01, on: RunLoop.main, in: RunLoop.Mode.default)
            .autoconnect()
            .sink(receiveValue: { (_) in
                self.objectWillChange.send()
                
                let percent = self.alongTrackDistance / self.track.totalArcLength
                
                let increaseDistance = self.track.totalArcLength / self.type.speed / (UIDevice.isIPad ? 0.65 : 1)
                self.alongTrackDistance += percent < 0.1 || percent > 0.9 ? increaseDistance * 2 : increaseDistance
                
                if self.alongTrackDistance > self.track.totalArcLength {
                    self.timer?.cancel()
                    self.onDestroy?()
                    self.visible = false
                }
            })
    }
    
    func save() {
        self.objectWillChange.send()
        self.timer?.cancel()
        
        saved = true
        visible = false
    }
    
    func remove() {
        self.objectWillChange.send()
        self.timer?.cancel()
        
        removed = true
        visible = false
    }
}

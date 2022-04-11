//
//  Model-Animal.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import Combine
import SwiftUI

class Animal: Identifiable, ObservableObject {
    private(set) var id = UUID()
    
    private(set) var l2r: Bool
    private var alongTrackDistance = CGFloat.zero
    private var timer: Cancellable? = nil
    private let track: ParametricCurve
    let path: Path
    var onDestroy: (() -> Void)? = nil
    
    var saved: Bool = false
    var visible: Bool = true
 
    init(from: CGPoint, to: CGPoint, control1: CGPoint, control2: CGPoint, l2r: Bool, onDestroy: (() -> Void)? = nil) {
        track = Bezier3(from: from, to: to, control1: control1, control2: control2)
        
        path = Path({ (path) in
            path.move(to: from)
            path.addCurve(to: to, control1: control1, control2: control2)
        })
        
        self.l2r = l2r
        self.onDestroy = onDestroy
        
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
                self.alongTrackDistance += self.track.totalArcLength / 60.0
                
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
}

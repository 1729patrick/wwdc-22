//
//  View-OceanWaveView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
// https://www.hackingwithswift.com/plus/custom-swiftui-components/creating-a-waveview-to-draw-smooth-waveforms

import SwiftUI

struct WaveView: Shape {
    var strength: Double
    var frequency: Double
    var start: Double
    var phase: Double
    
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height * start

        let wavelength = width / frequency

        path.move(to: CGPoint(x: 0, y: midHeight))

        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            
            let sine = sin(relativeX + phase)

            let y = strength * sine + midHeight

            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        return Path(path.cgPath)
    }
}

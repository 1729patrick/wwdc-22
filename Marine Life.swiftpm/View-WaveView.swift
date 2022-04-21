//
//  View-OceanWaveView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
// https://www.hackingwithswift.com/plus/custom-swiftui-components/creating-a-waveview-to-draw-smooth-waveforms

import SwiftUI

struct WaveView: Shape {
    // how high our waves should be
    var strength: Double

    // how frequent our waves should be
    var frequency: Double

    var start: Double
    
    // how much to offset our waves horizontally
    var phase: Double
    
    // allow SwiftUI to animate the wave phase
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height * start

        // split our total width up based on the frequency
        let wavelength = width / frequency

        // start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))

        // now count across individual horizontal points one by one
        for x in stride(from: 0, through: width, by: 1) {
            // find our current position relative to the wavelength
            let relativeX = x / wavelength
            
            // calculate the sine of that position
            let sine = sin(relativeX + phase)

            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let y = strength * sine + midHeight

            // add a line to here
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        return Path(path.cgPath)
    }
}

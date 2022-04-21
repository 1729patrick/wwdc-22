//
//  Modifiers-ScaledButtonStyle.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 21/04/22.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

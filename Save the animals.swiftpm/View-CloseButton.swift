//
//  View-CloseButton.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 10/04/22.
//

import SwiftUI

struct CloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: 18, weight: .bold))
            .imageScale(.small)
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
    }
}


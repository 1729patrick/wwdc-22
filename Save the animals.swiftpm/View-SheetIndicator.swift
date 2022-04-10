//
//  View-SheetIndicator.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 10/04/22.
//

import SwiftUI

struct SheedIndicator: View {
    @Environment(\.dismiss) var dismiss
    
    var showDismiss: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 50)
                    .fill(.ultraThinMaterial)
                    .frame(width: 50, height: 5)
                Spacer()
            }
            .padding(.vertical, 5)
            
            Spacer()
        }
    }
}


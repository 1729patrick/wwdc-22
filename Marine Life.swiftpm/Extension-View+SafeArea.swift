//
//  Extension-View+SafeArea.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}

//
//  Extension-UIDevice+Idiom.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 21/04/22.
//

import SwiftUI

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

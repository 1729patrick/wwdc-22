//
//  File.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 21/04/22.
//

import SwiftUI

struct ConservationStatus: Decodable, Encodable, Hashable, Identifiable {
    var id: String {
        code
    }
    
    var code: String
    var description: String
    var color: String
    
    
    static let EX = ConservationStatus(code: "EX", description: "Extinct", color: "Black" )
    static let EW = ConservationStatus(code: "EW", description: "Extinct in the Wild", color: "Midnight")
    static let CR = ConservationStatus(code: "CR", description: "Critically Endangered", color: "Red")
    static let EN = ConservationStatus(code: "EN", description: "Endangered", color: "Orange")
    static let VU = ConservationStatus(code: "VU", description: "Vulnerable", color: "Light Gold")
    static let NT = ConservationStatus(code: "NT", description: "Near Threatened", color: "Teal")
    static let LC = ConservationStatus(code: "LC", description: "Least Concern", color: "Green")
    static let DD = ConservationStatus(code: "DD", description: "Data Deficient", color: "Dark Blue")
    
    
    static let statusValues: [ConservationStatus] = [
        ConservationStatus.EX,
        ConservationStatus.EW,
        ConservationStatus.CR,
        ConservationStatus.EN,
        ConservationStatus.VU,
        ConservationStatus.NT,
        ConservationStatus.LC,
        ConservationStatus.DD,
    ]
}




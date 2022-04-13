//
//  Model-AnimalType.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 12/04/22.
//

import Foundation

struct AnimalType: Identifiable {
    var id: String {
        image
    }
    
    let image: String
    let speed: Double
    let scale: Double
    
    static var data: [AnimalType] {
        [
            AnimalType(image: "Mustelus schmitti", speed: 900, scale: 2),
            AnimalType(image: "Atlantirivulus nudiventris", speed: 600, scale: 1),
            
            AnimalType(image: "Pristis pectinata", speed: 900, scale: 1.5),
            AnimalType(image: "Polyprion americanus", speed: 600, scale: 1),
            
            AnimalType(image: "Chelonia mydas", speed: 4000, scale: 1.25),
            AnimalType(image: "Epinephelus itajara", speed: 600, scale: 1),
            
            AnimalType(image: "Balaenoptera musculus", speed: 3000, scale: 3),
            AnimalType(image: "Spintherobolus papilliferus", speed: 600, scale: 1),
            
            AnimalType(image: "Galeorhinus galeus", speed: 900, scale: 2),
            AnimalType(image: "Austrolebias cinereus", speed: 600, scale: 1),
            
            AnimalType(image: "Carcharhinus galapagensis", speed: 900, scale: 2),
            AnimalType(image: "Hypsolebias auratus", speed: 600, scale: 1),
            
            AnimalType(image: "Carcharhinus isodon", speed: 900, scale: 2),
            AnimalType(image: "Leporinus guttatus", speed: 600, scale: 1),
            
            AnimalType(image: "Pontoporia blainvillei", speed: 900, scale: 1.5),
            AnimalType(image: "Austrolebias jaegari",  speed: 600, scale: 1),

            AnimalType(image: "Characidium vestigipinne", speed: 600, scale: 1),
            AnimalType(image: "Myliobatis ridens", speed: 1500, scale: 1.25),
            
            AnimalType(image: "Prochilodus britskii", speed: 600, scale: 1),
            AnimalType(image: "Sphyrna lewini", speed: 900, scale: 2),
            
            AnimalType(image: "Schroederichthys bivius", speed: 600, scale: 1),
            AnimalType(image: "Cetorhinus maximus", speed: 900, scale: 2),
            AnimalType(image: "Baryancistrus longipinnis", speed: 600, scale: 1),
                    
            
            AnimalType(image: "Brycon vermelha", speed: 600, scale: 1),
            AnimalType(image: "Odontesthes bicudo", speed: 600, scale: 1)
            ]
    }
}


//
//  Model-Sounds.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 13/04/22.
//

import Foundation


protocol Sound {
    func getFileName() -> String
    func getFileExtension() -> String
    func getVolume() -> Float
    func isLoop() -> Bool
}

extension Sound {
    func getVolume() -> Float { 1 }
    func isLoop() -> Bool { false }
}


struct BackgroundSound: Sound {
    func getFileName() -> String { "background" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.7
    }
    func isLoop() -> Bool {
        true
    }
}

struct ButtonSound: Sound {
    func getFileName() -> String { "button" }
    func getFileExtension() -> String { "wav" }
    func getVolume() -> Float {
        0.3
    }
}

struct FishSound: Sound {
    func getFileName() -> String { "fish" }
    func getFileExtension() -> String { "wav" }
    func getVolume() -> Float {
        0.4
    }
}

struct WrongSound: Sound {
    func getFileName() -> String { "wrong" }
    func getFileExtension() -> String { "wav" }
    func getVolume() -> Float {
        0.4
    }
}

struct FeedSound: Sound {
    func getFileName() -> String { "feed" }
    func getFileExtension() -> String { "wav" }
    func getVolume() -> Float {
        0.6
    }
}

struct OilSpillSound: Sound {
    func getFileName() -> String { "oilSpill" }
    func getFileExtension() -> String { "wav" }
    func getVolume() -> Float {
        0.6
    }
    func isLoop() -> Bool { true }
}

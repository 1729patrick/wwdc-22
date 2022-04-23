//
//  Model-Sounds.swift
//  Marine Life
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
        0.15
    }
    func isLoop() -> Bool {
        true
    }
}

struct InspiringSound: Sound {
    func getFileName() -> String { "inspiring" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.3
    }
    func isLoop() -> Bool {
        true
    }
}

struct ButtonSound: Sound {
    func getFileName() -> String { "button" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.1
    }
}

struct SwimmerSound: Sound {
    func getFileName() -> String { "swimmer" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.1
    }
}

struct WrongSound: Sound {
    func getFileName() -> String { "wrong" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.1
    }
}

struct FeedSound: Sound {
    func getFileName() -> String { "feed" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.3
    }
}

struct OilSpillSound: Sound {
    func getFileName() -> String { "oilSpill" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.2
    }
    func isLoop() -> Bool { true }
}

struct LevelSound: Sound {
    func getFileName() -> String { "level" }
    func getFileExtension() -> String { "m4a" }
    func getVolume() -> Float {
        0.2
    }
}

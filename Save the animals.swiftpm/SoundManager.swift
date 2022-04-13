//
//  SoundManager.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 13/04/22.
//


import AVFAudio

final class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let shared = SoundManager()
    
    private var audioPlayers: [URL: AVAudioPlayer] = [:]
    private var duplicateAudioPlayers: [AVAudioPlayer] = []
    
    private override init() {}
    
    func play(sound: Sound) {
        
        let fileName = sound.getFileName()
        let fileExtension = sound.getFileExtension()
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return }
        guard let player = getAudioPlayer(for: url) else { return }
        player.volume = sound.getVolume()
        player.numberOfLoops = sound.isLoop() ? Int.max : 0
        player.prepareToPlay()
        player.play()
    }
    
    private func getAudioPlayer(for url: URL) -> AVAudioPlayer? {
        guard let player = audioPlayers[url] else {
            let player = try? AVAudioPlayer(contentsOf: url)
            audioPlayers[url] = player
            return  player
        }
        guard player.isPlaying else { return player }
        guard let duplicatePlayer = try? AVAudioPlayer(contentsOf: url) else { return nil }
        duplicatePlayer.delegate = self
        duplicateAudioPlayers.append(duplicatePlayer)
        return duplicatePlayer
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        duplicateAudioPlayers.removeAll { $0 == player }
    }
}

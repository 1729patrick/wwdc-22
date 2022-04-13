import AVFoundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .preferredColorScheme(.dark)
            .onAppear {
                SoundManager.shared.play(sound: BackgroundSound())
            }
    }
}



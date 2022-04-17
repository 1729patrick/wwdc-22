import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .onAppear {
                    SoundManager.shared.play(sound: BackgroundSound())
                }
        }
    }
}

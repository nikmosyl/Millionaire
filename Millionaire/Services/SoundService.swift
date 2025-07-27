//
//  SoundService.swift
//  Millionaire
//
//  Created by nikita on 27.07.2025.
//

import Foundation

import Foundation

enum SoundName: String {
    case tick = "tick"
    case win = "win"
    case lose = "lose"
    case millioner = "millioner"

    var fileName: String {
        return self.rawValue
    }

    var fileExtension: String {
        return "mp3"
    }
}

import AVFoundation

final class SoundService {
    private var player: AVAudioPlayer?

    func play(sound: SoundName) {
        guard let url = Bundle.main.url(forResource: sound.fileName, withExtension: sound.fileExtension) else {
            print("❌ Could not find file: \(sound.fileName).\(sound.fileExtension)")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("▶️ Playing sound: \(sound.fileName)")

            // Остановить воспроизведение через 5 секунд
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.player?.stop()
                print("⏹️ Stopped sound after 5 seconds")
            }

        } catch {
            print("❌ Failed to play sound: \(error.localizedDescription)")
        }
    }
}

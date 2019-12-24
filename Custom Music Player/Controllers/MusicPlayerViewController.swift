import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    // Audio player instance.
    var audioPlayer: AVAudioPlayer?
    
    // Play/pause control status variables.
    var playing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMusicPlayer()
    }
    
    func configureMusicPlayer() {
        /* Called to set the song to the audio player and
           create an audio session in order for the audio
           player to play the song. */
        let filePathUrl = Bundle.main.url(forResource: "Nemesis - Kobe (Official)", withExtension: "mp3")
        
        guard filePathUrl != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl! )
            audioPlayer?.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: .mixWithOthers)
            try audioSession.setMode(.default)
        } catch {
            print(error)
        }
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        // Called when the play pause button gets tapped.
        print("Play/Pause tapped.")
        if !playing {
            audioPlayer?.play()
        } else {
            audioPlayer?.pause()
        }

        // Change playing status.
        playing = !playing
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
    }
    
}

/* This extension implements the required AVAudioPlayerDelegate
   protocol functions. */
extension MusicPlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio did finish playing!")
    }
}


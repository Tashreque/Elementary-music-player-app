import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    // Audio player instance.
    var audioPlayer = AVAudioPlayer()
    
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
        let filePathString = Bundle.main.path(forResource: "Nemesis - Kobe (Official)", ofType: "mp3")
        let filePathURL = URL(fileURLWithPath: filePathString!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePathURL)
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: .mixWithOthers)
            try audioSession.setMode(.default)
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        // Called when the play pause button gets tapped.
        if !playing {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }

        // Change playing status.
        playing = !playing
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
    }
    
}


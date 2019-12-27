import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    //IBOutlet references.
    @IBOutlet weak var audioPositionSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureMusicPlayer()
    }
    
    func configureMusicPlayer() {
        /* Called to set the song to the audio player and
           create an audio session in order for the audio
           player to play the song. */
        if let audioPlayer = audioPlayer {
            // Handle real time slider update.
            audioPositionSlider.maximumValue = Float(audioPlayer.duration)
            volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
            audioPlayer.prepareToPlay()
            let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePositionSlider), userInfo: nil, repeats: true)
        } else {
            print("Error playing current audio!")
        }
    }
    
    @objc func updatePositionSlider() {
        /* Called after a certain time interval to update the
           slider in real time. */
        if let audioPlayer = audioPlayer {
            audioPositionSlider.value = Float(audioPlayer.currentTime)
        } else {
            print("Unable to update slider in real time!")
        }
    }
    
    @IBAction func audioPositionSliderDragged(_ sender: UISlider) {
        // Called when the audio slider gets interacted with.
        if let audioPlayer = audioPlayer {
            let currentState = audioPlayer.isPlaying
            audioPlayer.stop()
            audioPlayer.currentTime = TimeInterval(audioPositionSlider.value)
            audioPlayer.prepareToPlay()
            
            // Check if already playing.
            if audioPlayer.isPlaying != currentState {
                audioPlayer.play()
            }
        } else {
            print("Error during updating track position!")
        }
    }
    
    @IBAction func volumeSliderDragged(_ sender: UISlider) {
        // Called when the volume slider gets interacted with.
        if let audioPlayer = audioPlayer {
            audioPlayer.volume = volumeSlider.value
        } else {
            print("Error updating volume!")
        }
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        // Called when the play pause button gets tapped.
        print("Play/Pause tapped.")
        if let audioPlayer = audioPlayer {
            if !audioPlayer.isPlaying {
                audioPlayer.play()
            } else {
                audioPlayer.pause()
            }
        } else {
            print("Audio player error during play/pause!")
        }
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
    }
}


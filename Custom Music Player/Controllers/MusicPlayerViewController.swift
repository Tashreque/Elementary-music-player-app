import UIKit
import AVFoundation

// This class accounts for the Music player view.
class MusicPlayerViewController: UIViewController {

    //IBOutlet references.
    @IBOutlet weak var audioPositionSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var currentSongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureMusicPlayer()
        print(currentSongIndex)
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
        
        currentSongLabel.text = allSongs[currentSongIndex].songName
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
        // Called to go back one track.
        if !allSongs.isEmpty {
            currentSongIndex -= 1
            if currentSongIndex < 0 {
                currentSongIndex = 0
            }
            
            // Start playing new track.
            let filePathUrl = allSongs[currentSongIndex].songUrl
            
            // Go to previous song.
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl)
                if let audioPlayer = audioPlayer {
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                }
            } catch {
                print(error)
            }
            print("Current song: \(allSongs[currentSongIndex].songName)")
        }
        
        // Update current song label text.
        currentSongLabel.text = allSongs[currentSongIndex].songName
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        // called to skip current track.
        let maxIndex = allSongs.count - 1
        if !allSongs.isEmpty {
            currentSongIndex += 1
            if currentSongIndex > maxIndex {
                currentSongIndex = 0
            }
            
            // Start playing new track.
            let filePathUrl = allSongs[currentSongIndex].songUrl
            
            // Go to next song.
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl)
                if let audioPlayer = audioPlayer {
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                }
            } catch {
                print(error)
            }
            print("Current song: \(allSongs[currentSongIndex].songName)")
        }
        
        // Update current song label text.
        currentSongLabel.text = allSongs[currentSongIndex].songName
    }
    
}


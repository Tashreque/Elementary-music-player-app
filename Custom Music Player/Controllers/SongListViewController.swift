import UIKit
import AVFoundation

// This class accounts for the list of songs that can be played.
class SongListViewController: UIViewController {
    
    // IBOutlet references.
    @IBOutlet weak var songListTableView: UITableView!
    
    // Song holder.
    private var songs = [SongDataModel]() {
        didSet {
            allSongs = songs
            songListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let controllerHelper = SongListViewControllerHelper()
        songs = controllerHelper.getSongDataModels()
        
        initializeAudioPlayer()
    }
    
    func initializeAudioPlayer() {
        let filePathUrl = songs[currentSongIndex].songUrl
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl)
            if let audioPlayer = audioPlayer {
                audioPlayer.prepareToPlay()
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func addMusicFromDropboxTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func dropboxButtonDidTap(_ sender: UIBarButtonItem) {
        /* Called when the dropbox button gets tapped.
           This initiates the flow for the dropbox authentication and download. */
        let requestHandler = DropboxHandler.shared
        requestHandler.startAuthorisation(controller: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/* This extension implements the UITableViewDelegate and
   UITableViewDataSource protocol functions */
extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    // Callback to set the total number of rows.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Callback to return reusable UITableViewCell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell") as! SongTableViewCell
        cell.songNameLabel.text = songs[indexPath.row].songName
        cell.songArtistLabel.text = songs[indexPath.row].songArtist
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Callback to set height of UITableViewCell.
        return tableView.frame.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Called to trigger song corresponding to the cell.
        let filePathUrl = songs[indexPath.row].songUrl
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl)
            if let audioPlayer = audioPlayer {
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }
        } catch {
            print(error)
        }
        
        /* Make the music player view controller aware of
           the current song index. */
        currentSongIndex = indexPath.row
    }
    
}

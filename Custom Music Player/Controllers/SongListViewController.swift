import UIKit
import AVFoundation

// This class accounts for the list of songs that can be played.
class SongListViewController: UIViewController {
    
    // IBOutlet references.
    @IBOutlet weak var songListTableView: UITableView!
    @IBOutlet weak var dropboxButton: UIBarButtonItem!
    
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
        
        // Set dropbox button status.
        let loggedIn = DropboxHandler.shared.checkIfLoggedIn()
        if loggedIn {
            dropboxButton.title = "Unlink"
        }
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
        /* Called to add new songs from dropbox upon
           authentication. */
        let loggedIn = DropboxHandler.shared.checkIfLoggedIn()
        print()
        if !loggedIn {
            print("Not linked! Show an alert.")
            
            let notLinkedAlert = UIAlertController(title: "Connect to Dropbox?", message: "Downloading songs to the library requires connection to dropbox.", preferredStyle: .actionSheet)
            notLinkedAlert.addAction(UIAlertAction(title: "Connect", style: .default, handler: { (action) in
                // Log in action.
                DropboxHandler.shared.startAuthorisation(controller: self)
                self.dropboxButton.title = "Unlink"
                
                notLinkedAlert.dismiss(animated: true, completion: nil)
                
            }))
            notLinkedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                // Cancelation action.
                notLinkedAlert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(notLinkedAlert, animated: true, completion: nil)
            
        } else {
            print("Logged in, songs can be added.")
        }
    }
    
    @IBAction func dropboxButtonDidTap(_ sender: UIBarButtonItem) {
        /* Called when the dropbox button gets tapped.
           This initiates the flow for the dropbox authentication and download. */
        let loggedIn = DropboxHandler.shared.checkIfLoggedIn()
        if loggedIn {
            DropboxHandler.shared.clearAccessTokens()
            sender.title = "Dropbox"
        } else {
            DropboxHandler.shared.startAuthorisation(controller: self)
            sender.title = "Unlink"
        }
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

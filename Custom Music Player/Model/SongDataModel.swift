import Foundation
import UIKit

/* Model class for a song.*/
class SongDataModel {
    let songUrl: URL
    let songName: String
    let songExtension: String
    let songArtist: String
    let songAlbum: String
    
    init(songUrl: URL, songName: String, songExtension: String, songArtist: String, songAlbum: String) {
        self.songUrl = songUrl
        self.songName = songName
        self.songExtension = songExtension
        self.songAlbum = songAlbum
        self.songArtist = songArtist
    }
}

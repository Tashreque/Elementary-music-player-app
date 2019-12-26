import Foundation
import UIKit

/* Model class for a song.*/
class SongDataModel {
    let songName: String
    let songExtension: String
    let songArtist: String
    let songAlbum: String
    
    init(songName: String, songExtension: String, songArtist: String, songAlbum: String) {
        self.songName = songName
        self.songExtension = songExtension
        self.songAlbum = songAlbum
        self.songArtist = songArtist
    }
}

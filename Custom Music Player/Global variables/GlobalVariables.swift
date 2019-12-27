import AVFoundation

// Global AVAudioPlayer instance available to all classes.
var audioPlayer: AVAudioPlayer?

// Global list of all songs available to all classes.
var allSongs: [SongDataModel] = []

// Global current song index available to all classes.
var currentSongIndex = 0

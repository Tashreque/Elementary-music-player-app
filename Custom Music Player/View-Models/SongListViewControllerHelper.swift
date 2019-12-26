import Foundation

/* This is the view model class for the
   MusicPlayerViewController which handles the retrieval of
   song paths, song names or song extensions. */
class SongListViewControllerHelper {
    
    func getSongDataModels() -> [SongDataModel] {
        return []
    }
    
    func getCurrentSongUrls() -> [URL] {
        // Called to retrieve the URL for each song
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        var songUrls = [URL]()
        
        do {
            let contentsInFolder = try FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // Get URLs with mp3/wav files only.
            for each in contentsInFolder {
                if each.absoluteString.contains(".mp3") || each.absoluteString.contains(".wav") {
                    songUrls.append(each)
                }
            }
        } catch {
            print(error)
        }
        
        return songUrls
    }
    
    func getCurrentSongNames(for songUrls: [URL]) -> [String] {
        // Called to extract song names from the URLs.
        var songNames = [String]()
        for url in songUrls {
            let urlString = url.absoluteString
            let dividedSections = urlString.components(separatedBy: "/")
            var songName = dividedSections[dividedSections.count - 1]
            
            // Replace "%20" with space in each song name.
            songName = songName.replacingOccurrences(of: "%20", with: " ")
            
            // Derive extension from song name.
            let namePartitions = songName.components(separatedBy: ".")
            let songExtension = namePartitions[namePartitions.count - 1]
            
            // Remove song extensions.
            switch songExtension {
            case "wav":
                songName = songName.replacingOccurrences(of: ".wav", with: "")
            default:
                songName = songName.replacingOccurrences(of: ".mp3", with: "")
            }
            
            // Add corrected song name to list of song names.
            songNames.append(songName)
        }
        return songNames
    }
    
    func getCurrentSongExtensions(for songUrls: [URL]) -> [String] {
        // Called to return song extensions from the URLs.
        var songExtensions = [String]()
        for url in songUrls {
            let urlString = url.absoluteString
            let dividedSections = urlString.components(separatedBy: "/")
            let songName = dividedSections[dividedSections.count - 1]
            
            // Derive extension from song name.
            let namePartitions = songName.components(separatedBy: ".")
            let songExtension = namePartitions[namePartitions.count - 1]
            
            // Detect song extension type.
            switch songExtension {
            case "wav":
                songExtensions.append("wav")
            default:
                songExtensions.append("mp3")
            }
        }
        return songExtensions
    }
}

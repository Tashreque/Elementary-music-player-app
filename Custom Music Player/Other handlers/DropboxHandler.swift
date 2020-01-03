import Foundation
import SwiftyDropbox

/* This singleton class handles dropbox related requests. */
class DropboxHandler {
    
    // Static one time only instance.
    static let shared = DropboxHandler()
    
    private init() {}
    
    func startAuthorisation(controller: UIViewController) {
        /* Called to handle dropbox authorisation. This
           launches a SFSafariViewController to handle
           dropbox authentication. */
        DropboxClientsManager.authorizeFromController(.shared, controller: controller) { (url) in
            UIApplication.shared.canOpenURL(url)
        }
    }
    
    func handleAuthenticationResult(url: URL) {
        // Called to handle authentication result.
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
    }
    
    func listContentsWithin() {
        // Called to display songs within a certain directory in the user's dropbox account.
        let client = DropboxClientsManager.authorizedClient
        if let client = client {
            let files = client.files.listFolder(path: "/home/Saves", recursive: true, includeMediaInfo: true)
            files.response { (listFolderResult, error) in
                if let result = listFolderResult {
                    let entries = result.entries
                    DispatchQueue.main.async {
                        print("Count = \(entries.count)")
                        for entry in entries {
                            print(entry.name)
                        }
                    }
                }
            }
            print(files)
        }
    }
    
    func checkIfLoggedIn() -> Bool {
        // Called to check whether a user is logged in.
        if let authorisedClient = DropboxClientsManager.authorizedClient {
            print(authorisedClient.users.getCurrentAccount())
            return true
        }
        return false
    }
    
    func clearAccessTokens() {
        // Clear access tokens and unlink user account from dropbox.
        DropboxClientsManager.unlinkClients()
    }
}

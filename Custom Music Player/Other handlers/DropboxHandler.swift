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
}

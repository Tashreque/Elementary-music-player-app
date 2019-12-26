import UIKit

class SongListViewController: UIViewController {

    // IBOutlet references.
    @IBOutlet weak var songListTableView: UITableView!
    
    // Song holder.
    private var songs = [SongDataModel]() {
        didSet {
            songListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let controllerHelper = SongListViewControllerHelper()
        songs = controllerHelper.getSongDataModels()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Calback to set height of UITableViewCell.
        return tableView.frame.height * 0.1
    }
    
}

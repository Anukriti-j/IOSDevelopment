import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyingImageAttributes()
        modifyingLabelViews()
    }
    func modifyingImageAttributes(){
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
        avatarImageView.clipsToBounds = true
    }
    func modifyingLabelViews(){
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
}


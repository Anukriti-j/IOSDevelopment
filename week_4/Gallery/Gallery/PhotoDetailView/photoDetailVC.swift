import UIKit

class photoDetailVC: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var selectedImage: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    
    func setImage() {
        if let photo = selectedImage {
            photoImageView.image = UIImage(named: photo.image)
            detailLabel.text = "Details for: \(photo.image)"
        }
    }
}

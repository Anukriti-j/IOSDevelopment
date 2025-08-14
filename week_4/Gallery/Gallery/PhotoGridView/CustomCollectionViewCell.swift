import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gridImageView: UIImageView!
    
    func setPhotoCollection(with photo: Photo) {
        DispatchQueue.global().async {
            let image = UIImage(named: photo.image)
            
            DispatchQueue.main.async {
                self.gridImageView.image = image
            }
        }
    }
}

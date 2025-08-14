import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    
    var photoCount: Int?
    
    func setupCategory(with data: Category, photoCount: Int) {
        categoryImageView.image = UIImage(named: data.image)
        categoryLabel.text = data.title
        photoCountLabel.text = String(photoCount)
    }
}

import UIKit

class ContactDetailVC: UIViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContactDetails()
        self.title = contact?.name
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setImageView()
    }
    
    func setContactDetails() {
        nameLabel.text = contact?.name ?? "No name found"
        phoneLabel.text = contact?.phoneNumber ?? "No number found"
        mailLabel.text = contact?.email ?? "No email found"
        if  let personImage = contact?.imageName, let image = UIImage(named: personImage) {
            personImageView.image = image
        }
        else {
            personImageView.image = UIImage(systemName: "person.crop.circle.fill") // Use a system placeholder
            personImageView.tintColor = .systemGray
        }
    }
    
    func setImageView() {
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
        personImageView.layer.borderWidth = 2
        personImageView.layer.borderColor = UIColor.black.cgColor
        
    }
}

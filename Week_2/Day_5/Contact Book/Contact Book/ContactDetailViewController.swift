import UIKit

class ContactDetailViewController: UIViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContactDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setImageView()
    }
    
    func setContactDetails() {
        guard let contact = contact else {
            nameLabel.text = Strings.unknownName
            phoneLabel.text = Strings.noContactNumber
            mailLabel.text = Strings.noEMail
            personImageView.image = UIImage(systemName: "person.crop.circle.fill") // Use a system placeholder
            personImageView.tintColor = .systemGray
            return
        }
        nameLabel.text = contact.name
        phoneLabel.text = contact.phoneNumber
        mailLabel.text = contact.email
        personImageView.image = UIImage(named: contact.imageName)
    }
    
    func setImageView() {
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
        personImageView.layer.borderWidth = 2
        personImageView.layer.borderColor = UIColor.black.cgColor
        
    }
}

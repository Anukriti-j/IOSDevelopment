import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var nameListTableView: UITableView!
    
    let contactList = ContactData.contactList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameListTableView.delegate = self
        nameListTableView.dataSource = self
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "showDetailSegue",
//               let destination = segue.destination as? ContactDetailViewController,
//               let indexPath = nameListTableView.indexPathForSelectedRow {
//                let selectedContact = contactList[indexPath.row]
//                destination.contact = selectedContact
//            }
//    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = contactList[indexPath.row]
        cell.textLabel?.text = contact.name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetailSegue", sender: self)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contactList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController {
            detailVC.contact = selectedContact
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


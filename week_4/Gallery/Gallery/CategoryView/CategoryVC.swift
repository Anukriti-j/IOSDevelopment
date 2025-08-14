import UIKit

class CategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! CustomTableViewCell
        let category = photoCategories[indexPath.row]
        let photoCount = category.photos.count
        cell.setupCategory(with: category, photoCount: photoCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = photoCategories[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoGridVC = storyboard.instantiateViewController(withIdentifier: "GridCollectionVC") as! GridCollectionVC
        photoGridVC.filteredPhotos = selectedCategory.photos
        photoGridVC.title = selectedCategory.title
        navigationController?.pushViewController(photoGridVC, animated: true)
    }
}

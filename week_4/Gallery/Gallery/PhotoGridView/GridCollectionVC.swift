import UIKit

class GridCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredPhotos: [Photo] = []
    var isGridLayout =  true
    var draggedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        customNavbar()
        addLongPressGesture()
    }
    
    func customNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "List",
            style: .plain,
            target: self,
            action: #selector(toggleLayout)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCollectionCell", for: indexPath) as! CustomCollectionViewCell
        cell.setPhotoCollection(with: filteredPhotos[indexPath.row])
        return cell
    }
    
    // MARK: - Drag and Drop using Gesture Recognizers
    
    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPresGesture(_:)))
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPresGesture(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
            draggedIndexPath = indexPath
        case .changed:
            guard let draggedIndexPath = draggedIndexPath else { return }
            if let newIndexPath = collectionView.indexPathForItem(at: location), newIndexPath != draggedIndexPath {
                filteredPhotos.swapAt(draggedIndexPath.item, newIndexPath.item)
                collectionView.moveItem(at: draggedIndexPath, to: newIndexPath)
                self.draggedIndexPath = newIndexPath
            }
        case .ended, .cancelled:
            draggedIndexPath = nil
        default:
            break
        }
        
    }
    
    @objc func toggleLayout() {
        collectionView.dragInteractionEnabled = false
        isGridLayout.toggle()
        
        if collectionView.collectionViewLayout is UICollectionViewFlowLayout {
            UIView.animate(withDuration: 0.4) {
                self.collectionView.performBatchUpdates(nil)
            }
            //            layout.invalidateLayout()
        }
        navigationItem.rightBarButtonItem?.title = isGridLayout ? "List" : "Grid"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView.dragInteractionEnabled = true
        }
    }
}

extension GridCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        
        if isGridLayout {
            let totalSpacing = spacing * 6
            let width = (collectionView.bounds.width - totalSpacing) / 4
            return CGSize(width: width, height: width)
        } else {
            let totalSpacing = spacing * 2
            let width = (collectionView.bounds.width - totalSpacing)
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = filteredPhotos[indexPath.row]
        let main = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = main.instantiateViewController(withIdentifier: "photoDetailVC") as! photoDetailVC
        photoVC.selectedImage = selectedItem
        navigationController?.pushViewController(photoVC, animated: true)
    }
}

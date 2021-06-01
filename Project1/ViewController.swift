//
//  ViewController.swift
//  Project1
//
//  Created by Azat Kaiumov on 16.05.2021.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
    @objc func loadPictures() {
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        
        let files = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        for file in files {
            if file.hasPrefix("nssl") {
                pictures.append(file)
            }
        }
        
        pictures.sort()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PictureCell")
        }
        
        let picture = pictures[indexPath.item]
        cell.name.text = picture
        cell.imageView.image = UIImage(named: picture)
        cell.imageView.layer.cornerRadius = 10
        
        return cell
    }
    
    func openDetailView(pictureIndex: Int) {
        let picture = pictures[pictureIndex]
        
        guard let detailViewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController else {
            return
        }
        
        detailViewController.selectedImage = picture
        detailViewController.totalNumberOfImages = picture.count
        detailViewController.selectedImageIndex = pictureIndex
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openDetailView(pictureIndex: indexPath.item)
    }
}


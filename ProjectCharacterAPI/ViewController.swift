//
//  ViewController.swift
//  CharacterInfo
//
//  Created by George Popkich on 12.10.23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    
    
    
    @IBOutlet private var CollectionView: UICollectionView!
    

    private var characterInfo: CharacterInfo?{
        didSet{
            CollectionView.reloadData()
        }
    }
    
    private var networkService = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CollectionView.dataSource  = self
        loadInfo()
      
        
    }
    
    
    private func loadInfo() {
        networkService.loadInfo { [weak self] characterInfo  in
            self?.characterInfo = characterInfo
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return characterInfo?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifire, for: indexPath) as? CollectionViewCell else {return cell}
        cardCell.characterName.text =  characterInfo?.results[indexPath.section].name
        cardCell.race.text =  characterInfo?.results[indexPath.section].species
        cardCell.status.text =  characterInfo?.results[indexPath.section].status
        cardCell.image.contentMode = .scaleAspectFill
        guard let result = characterInfo?.results[indexPath.section] else {return cell}
        let imageString = result.image;
        if let imageURL = URL(string: imageString){
            // сделал через кложур, не помню как правильнее
            networkService.loadImage(url: imageURL) {  characterImage in
                cardCell.image.image = characterImage
            }
        }
        
        //реализация через extention UIImageView
//        cardCell.image.downloaded(from: imageURL!)
        
        
        
        return cardCell
    }
    

}

// нашел на stackoverflow

    extension UIImageView {
        func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
 



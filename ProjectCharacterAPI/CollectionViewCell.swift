//
//  CollectionViewCell.swift
//  ProjectCharacterAPI
//
//  Created by George Popkich on 12.10.23.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static var identifire = "CollectionViewCell"
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var race: UILabel!
}

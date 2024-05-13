//
//  TableCell.swift
//  GameOfLife
//
//  Created by Lambert Lani on 5/13/24.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var lableBig: UILabel!
    @IBOutlet weak var lableLitle: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    func configure(with imageName: String, text: String, textLitle: String) {
        cellImageView.image = UIImage(named: imageName)
        lableBig?.text = text
        lableLitle?.text = textLitle
        
        setup()
    }
    
    func setup() {
        cellImageView.clipsToBounds = true
        
        lableBig.textAlignment = .left
        lableBig.font = UIFont.systemFont(ofSize: 24)
        
        lableLitle.textAlignment = .left
        lableLitle.font = UIFont.systemFont(ofSize: 16)
    }
}

//
//  SmartCollectionsCell.swift
//  Product
//
//  Created by Zienab on 11/03/2023.
//

import UIKit

class SmartCollectionsCell: UICollectionViewCell {
    
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var editBrand: UIButton!
    @IBOutlet weak var deleteBrand: UIButton!
    
    var editSmartCollectioButton: (() -> ()) = {}
    var deleteSmartCollectioButton: (() -> ()) = {}
    
    @IBAction func editAction(_ sender: UIButton) {
        editSmartCollectioButton()
    }
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
        deleteSmartCollectioButton()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 2, bottom: 2, right: 2))
        
        
    }
}

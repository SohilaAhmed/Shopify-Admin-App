//
//  DisplayProductCell.swift
//  Shopify Admin App
//
//  Created by Zienab on 10/03/2023.
//

import UIKit

class DisplayProductCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!

    @IBOutlet weak var deleteBtn: UIButton!
    
    var deletProduct: (()->())?
    var editProduct: (()->())?
    
    @IBAction func editProduct(_ sender: UIButton) {
        editProduct?()
    }
    
    @IBAction func deleteProduct(_ sender: UIButton) {
        deletProduct?()
    }
 
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
    
//        contentView.layer.cornerRadius = 20
//        contentView.layer.masksToBounds = true
        
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))

        
        }
}

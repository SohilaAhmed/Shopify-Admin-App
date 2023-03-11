//
//  CustomCollectionCell.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import UIKit

class CustomCollectionCell: UITableViewCell {

    @IBOutlet weak var customCollectionName: UILabel!
    
    var editCustomCollectioButton: (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    @IBAction func editCustomCollection(_ sender: Any) {
        editCustomCollectioButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
}

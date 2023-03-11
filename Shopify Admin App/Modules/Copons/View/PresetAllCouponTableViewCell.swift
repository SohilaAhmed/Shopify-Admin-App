//
//  PresetAllCouponTableViewCell.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import UIKit

class PresetAllCouponTableViewCell: UITableViewCell {

    @IBOutlet weak var couponTitleLabel: UILabel!
    @IBOutlet weak var couponValueLabel: UILabel!
    
    var editCouponButton: (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func EditCouponButton(_ sender: Any) {
          editCouponButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

}

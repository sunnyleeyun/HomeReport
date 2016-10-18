//
//  HomeListTableViewCell.swift
//  Home Report
//
//  Created by Andi Setiyadi on 9/1/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var sqftLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confiqureCell(home: Home){
        cityLabel.text = home.city
        categoryLabel.text = home.homeType
        bedLabel.text = String(home.bed)
        bathLabel.text = String(home.bath)
        sqftLabel.text = String(home.sqft)
        priceLabel.text = home.price.currencyFormatter
        
        let image = UIImage(data: home.image!)
        homeImageView.image = image
        homeImageView.layer.borderWidth = 1
        homeImageView.layer.cornerRadius = 4
    }
}

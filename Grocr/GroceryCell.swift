//
//  GroceryCell.swift
//  Grocr
//
//  Created by Thomas Bloss on 5/17/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class GroceryCell: UITableViewCell {

    @IBAction func itemButton(sender: AnyObject) {

        
       // print(button.backgroundImageForState(UIControlState.Normal))
        
        
    }
    
       
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
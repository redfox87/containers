//
//  infoView.swift
//  Grocr
//
//  Created by Thomas Bloss on 5/20/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class infoView: UIViewController {



    @IBOutlet weak var infoLabel: UILabel!
    var receivedText: String = ""
    var receivedImage: UIImage = UIImage(named: "1")!
    @IBOutlet weak var infoImage: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(receivedImage)
//        infoLabel.text = receivedText!
//        infoImage.image = receivedImage!
        
    }

    override func viewWillAppear(animated: Bool) {
        
        print(receivedText)
        
        infoLabel.text = receivedText
        infoImage.image = receivedImage

    }
}
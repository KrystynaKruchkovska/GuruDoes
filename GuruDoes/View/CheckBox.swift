
//
//  CheckBox.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    //images
    let checkedImage = UIImage.init(named: "checkedBox")
    let uncheckedImage = UIImage.init(named: "uncheckedBox")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)) , for: UIControl.Event.touchUpInside)
        isChecked = false
    }
    
 @objc func buttonClicked(sender: UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
        
    }
}

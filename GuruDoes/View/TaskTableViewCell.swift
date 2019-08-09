//
//  TaskTableViewCell.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    weak var delegate:CheckboxDelegate?
    
    @IBOutlet weak var checkbox: CheckBox!
    @IBOutlet weak var taskLabel: UILabel!
 
    func configureCell(task:Task){
        self.taskLabel.text = task.taskTitle
        self.checkbox.isChecked = task.isDone
    }
    
    @IBAction func checkboxPressed(_ sender: CheckBox) {
        if let delegate = self.delegate {
            delegate.checkboxPressed(sender)
        }
    }
    
}

protocol CheckboxDelegate: class {
    func checkboxPressed(_ checkbox: CheckBox)
}

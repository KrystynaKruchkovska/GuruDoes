//
//  CreateTaskVC.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CreateTaskVC: UIViewController {
    
    var taskViewModel: CoreTaskViewModel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        refreshSaveButton()
        setupToHideKeyboardOnTapOnView()
    }
    
    @IBAction func addPriorityPressed(_ sender: Any) {
        showPriorityLevelAlert()
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        popVC(animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        taskViewModel.addTask(title: titleTextField.text!,
                              description: descriptionTextField.text!,
                              priorityLevel: .low) // TODO
        
        // todo, dismiss 
    }
    
    private func showPriorityLevelAlert(){
        let alert = UIAlertController(title: "Do you know level of priority for this task?", message: "Hight priority must be done first!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Definitely HIGH!", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                
                //self.addTask(priorityLevel: .high)
        }))
        
        alert.addAction(UIAlertAction(title: "Rather MEDIUM.", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                //self.addTask(priorityLevel: .middle)
        }))
        
        alert.addAction(UIAlertAction(title: "LOW!", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                //self.addTask(priorityLevel: .low)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CreateTaskVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        refreshSaveButton()
    }
}

extension CreateTaskVC {
    func refreshSaveButton() {
        
        if  titleTextField.text != "" &&
            descriptionTextField.text != ""  {
            
            saveBtn.isEnabled = true
            saveBtn.titleLabel?.textColor = UIColor.init(named: "turquoise")
        } else {
            saveBtn.isEnabled = false
            saveBtn.titleLabel?.textColor = UIColor.lightGray
        }
        
    }
}

extension CreateTaskVC: Navigatable {
    static var storyboardName: String {
        return "CreateTask"
    }
    
    static var storyboardId: String {
        return "CreateTaskVC"
    }
    
}


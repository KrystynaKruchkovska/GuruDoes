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
    
    // if taskNumber is Nil then this VC creates task
    // otherwise this VC modifies task
    var taskNumber:Int?
    
    @IBOutlet weak var detailNavigationItem: UINavigationItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        setupSaveButton()
        refreshSaveButton()
        setupToHideKeyboardOnTapOnView()
        
        taskViewModel.succesfullySave = { [weak self](success) in
            if success {
                Vibration.success.vibrate()
                self?.showAlert(title: "Your task is Saved", message: "JUST DO IT", alertActionTitle: "OK")
                
            } else{
                Vibration.error.vibrate()
                self?.showAlert(title: "Ouoch!", message: "Something went wrong!", alertActionTitle: "OK")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let taskNumber = taskNumber else {
            return
        }
        
        let coreTask = taskViewModel.coreTasks[taskNumber]
        
        titleTextField.text = coreTask.taskTitle
        descriptionTextField.text = coreTask.taskDescription
        
        saveBtn.isEnabled = false
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        popVC(animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let taskNumber = taskNumber {
            taskViewModel.modifyTask(title: titleTextField.text!,
                                     description: descriptionTextField.text!, taskIndex: taskNumber)
        } else {
            saveNewTask()
        }
    }
    
    private func saveNewTask() {
        taskViewModel.addTask(title: titleTextField.text!,
                              description: descriptionTextField.text!)

    }

    func refreshSaveButton() {
        
        let isTitleEmpty = titleTextField.text?.isEmpty ?? true
        let isDescriptionEmpty = titleTextField.text?.isEmpty ?? true
        
        if  !isTitleEmpty && !isDescriptionEmpty  {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
        
    }
    
    private func setupSaveButton() {
        self.saveBtn.setTitleColor(UIColor.init(named: "turquoise"), for: .normal)
        self.saveBtn.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
}

extension CreateTaskVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        refreshSaveButton()
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


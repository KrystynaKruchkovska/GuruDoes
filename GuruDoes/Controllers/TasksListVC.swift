//
//  TasksListVC.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TasksListVC: UIViewController {

    var taskViewModel: CoreTaskViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
 
        let nib = UINib.init(nibName: TaskTableViewCell.defaultReuseIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: TaskTableViewCell.defaultReuseIdentifier )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskViewModel.fetchTasks { (success) in
            self.tableView.reloadData()
        }
    }
    
    func indexPathForCheckbox(_ checkbox:CheckBox) -> IndexPath? {
        let visibleCells = tableView.visibleCells
        
        for cell in visibleCells {
            if let taskCell = cell as? TaskTableViewCell {
                if checkbox == taskCell.checkbox {
                    return tableView.indexPath(for: taskCell)
                }
            }
        }
        
        return nil
    }
    
    func showEdit(withIndexPath indexPath:IndexPath) {
        self.pushViewControllerOfType(viewControllerType: CreateTaskVC.self) { [weak self](vc) in
            vc.detailNavigationItem.title = "Edit Task"
            vc.taskViewModel = self?.taskViewModel
            vc.taskNumber = indexPath.row
        }
    }
}

extension TasksListVC: CheckboxDelegate {
    func checkboxPressed(_ checkbox: CheckBox) {
        
        guard let indexPath = indexPathForCheckbox(checkbox) else {
            return
        }
        
        taskViewModel.markAsDone(taskIndex: indexPath.row)
    }
    
    
}

extension TasksListVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.coreTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusableIdentifier = TaskTableViewCell.defaultReuseIdentifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:reusableIdentifier) as? TaskTableViewCell else {
            fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
        }
        
        let coreObject = taskViewModel.coreTasks[indexPath.row]
        cell.delegate = self
        cell.configureCell(task: coreObject)
        return cell
    }
    
}

extension TasksListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var actions = [UITableViewRowAction]()
        
        let editAction = UITableViewRowAction(style: .normal, title: "EDIT") { [weak self] (rowAction, indexPath) in
            
            self?.showEdit(withIndexPath: indexPath)
        }
        
        editAction.backgroundColor = .lightGray
        actions.append(editAction)
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.taskViewModel.removeTask(atIndexPath: indexPath)
            self.taskViewModel.fetchTasks(completion: { (success) in
            })
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = .red
        actions.append(deleteAction)
        
        return actions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEdit(withIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension TasksListVC: Navigatable {
    static var storyboardName: String {
        return "TasksList"
    }
    
    static var storyboardId: String {
        return "TasksList"
    }
    
}

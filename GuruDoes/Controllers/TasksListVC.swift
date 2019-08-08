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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskViewModel.fetchTasks { (success) in
            self.tableView.reloadData()
        }
    }
}

extension TasksListVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.coreTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = (taskViewModel.coreTasks[indexPath.row]).taskTitle
        return cell
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

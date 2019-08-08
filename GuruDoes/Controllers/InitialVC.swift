//
//  InitialVC.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    let taskViewModel: CoreTaskViewModel = CoreTaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        getCurrentDataTime()
    }
    
    @IBAction func showTasksPressed(_ sender: UIButton) {
        self.pushViewControllerOfType(viewControllerType: TasksListVC.self) { (vc) in
            vc.taskViewModel = taskViewModel
        }
    }
    
    @IBAction func createTaskPressed(_ sender: UIButton) {
        
        self.pushViewControllerOfType(viewControllerType: CreateTaskVC.self) { (vc) in
            vc.taskViewModel = taskViewModel
        }
    }

    
    
    private func getCurrentDataTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        dateLabel.text = formatter.string(from: Date())
    }

}

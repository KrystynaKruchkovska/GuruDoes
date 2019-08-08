//
//  CoreTaskViewModel.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import CoreData

class CoreTaskViewModel: NSObject {
    let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    var coreTasks:[Task] = []
    
    func addTask(title:String, description:String, priorityLevel:TaskPriority){
        guard let manegedContext = container?.viewContext else{return}
        let taskObject = Task(context: manegedContext)
        taskObject.taskTitle = title
        taskObject.taskDescription = description
        taskObject.priorityLevel = priorityLevel
        appendCoreObject(coreTask: taskObject)
    }
    
    func saveManegedContext(manegedContext:NSManagedObjectContext){
        
        do{
            try manegedContext.save()
            print("Successflly save managed context")
        }catch{
            debugPrint("Could not save managed context\(error.localizedDescription)")
        }
    }
    
    private func appendCoreObject(coreTask:Task){
        coreTasks.append(coreTask)
        
        guard let manegedContext = container?.viewContext else {
            return
        }
        
        saveManegedContext(manegedContext: manegedContext)
    }
    
    func fetchTasks( completion:(_ complete:Bool)->() ){
        guard  let manegedContext = container?.viewContext else {
            return
        }
        let className = String(describing: Task.self)
        let fetchRequest = NSFetchRequest<Task>(entityName: className)
        do{
            self.coreTasks = try manegedContext.fetch(fetchRequest)
            print("Successflly fetch data")
            completion(true)
        } catch {
            debugPrint("Could not catch \(error.localizedDescription)")
            completion(false)
        }
    }
    
}

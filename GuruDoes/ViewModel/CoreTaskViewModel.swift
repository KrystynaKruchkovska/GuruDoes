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
    var succesfullySave:((Bool)->())? = nil
    
    var coreTasks:[Task] = []
    
    func addTask(title:String, description:String){
        guard let manegedContext = container?.viewContext else{return}
        let taskObject = Task(context: manegedContext)
        taskObject.taskTitle = title
        taskObject.taskDescription = description
        appendCoreObject(coreTask: taskObject)
    }
    
    func modifyTask(title: String, description: String, taskIndex:Int) {
        let taskObject = coreTasks[taskIndex]
        taskObject.taskTitle = title
        taskObject.taskDescription = description
        guard let manegedContext = container?.viewContext else {
            return
        }
        saveManegedContext(manegedContext: manegedContext)
    }
    
    func saveManegedContext(manegedContext:NSManagedObjectContext){
        
        do{
            try manegedContext.save()
            succesfullySave?(true)
            print("Successflly save managed context")
        }catch{
            succesfullySave?(false)
            debugPrint("Could not save managed context\(error.localizedDescription)")
        }
    }
    
    func removeTask(atIndexPath indexPath: IndexPath) {
        self.removeManegedObject(atIndexPath: indexPath, manegedContext: container?.viewContext, managedObjectsArray: self.coreTasks)
    }

    
    func removeManegedObject(atIndexPath indexPath: IndexPath, manegedContext:NSManagedObjectContext?, managedObjectsArray:[NSManagedObject] ) {
        if let manegedContext = manegedContext {
            manegedContext.delete(managedObjectsArray[indexPath.row])
            saveManegedContext(manegedContext: manegedContext)
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

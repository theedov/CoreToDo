//
//  ToDoDataManager.swift
//  CoreToDo
//
//  Created by Bogdan on 5/2/21.
//

import UIKit

struct ToDoDataManager {
    static let shared = ToDoDataManager()
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// This function gets all to do items saved in CoreData
    /// - Parameter completion: Completion returns optional array of ToDoListItem
    func getAllItems(completion: ([ToDoListItem]?) -> Void) {
        do {
            let items: [ToDoListItem] = try context.fetch(ToDoListItem.fetchRequest())
            completion(items)
        } catch {
            completion(nil)
        }
    }
    
    /// This function created a to do list item
    /// - Parameters:
    ///   - name: Name of item eg. "Learn CoreData"
    ///   - completion: Completion returns true if item successfully saved
    func createItem(name: String, completion: (Bool) -> Void) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            completion(true)
        } catch{
            completion(false)
        }
    }
    
    /// This function deletes an item from CoreData
    /// - Parameters:
    ///   - item: ToDoListItem
    ///   - completion: Completion returns true if item successfully deleted
    func deleteItem(item: ToDoListItem, completion: (Bool) -> Void) {
        context.delete(item)
        
        do {
            try context.save()
            completion(true)
        } catch{
            completion(false)
        }
    }
    
    /// This function updates item in CoreData
    /// - Parameters:
    ///   - item: ToDoListItem
    ///   - newName: new to to list item name
    ///   - completion: Completion returns true if item successfully updated
    func updateItem(item: ToDoListItem, newName: String, completion: (Bool) -> Void) {
        item.name = newName
        
        do {
            try context.save()
            completion(true)
        } catch{
            completion(false)
        }
    }
}

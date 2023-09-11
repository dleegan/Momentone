//
//  Persistence.swift
//  Momentone
//
//  Created by dleegan on 08/09/2023.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        ["Note 1", "Note 2"].forEach { title in
            let note = Note(context: viewContext)
            note.id = UUID()
            note.title = "Note \(title)"
            note.content = title
            note.timestamp = Date()
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container:NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Momentone")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

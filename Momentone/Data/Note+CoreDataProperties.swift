//
//  Note+CoreDataProperties.swift
//  Momentone
//
//  Created by dleegan on 08/09/2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var timestamp: Date?

}

extension Note : Identifiable {

}

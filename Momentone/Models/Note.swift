//
//  Note.swift
//  Momentone
//
//  Created by dleegan on 27/09/2023.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var content: String
    var timestamp: Date
    
    init(title: String, content: String, timestamp: Date) {
        self.title = title
        self.content = content
        self.timestamp = timestamp
    }
}

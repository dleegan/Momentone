//
//  EditView.swift
//  Momentone
//
//  Created by dleegan on 08/09/2023.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var note: Note
    
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    
    var body: some View {
        VStack {
            Text(note.timestamp!, formatter: itemFormatter)
                .font(.footnote)
                .opacity(0.5)
            TextField("Title", text: $noteTitle)
                .font(.system(size: 25, weight: .bold))
            TextEditor(text: $noteContent)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            noteTitle = note.title ?? ""
            noteContent = note.content ?? ""
        }
        .onDisappear {
            note.title = noteTitle
            note.content = noteContent
            note.timestamp = Date()
            try? viewContext.save()
        }
        
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

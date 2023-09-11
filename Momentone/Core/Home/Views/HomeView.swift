//
//  HomeView.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: nil, animation: .linear)
    var notes:FetchedResults<Note>
    
    @State var textFieldText: String = ""
    @State var textNote: String = ""
    
    var body: some View {
        VStack () {
            List {
                ForEach (notes.sorted(by: { $0.timestamp! > $1.timestamp! })) { note in
                    NavigationLink {
                        EditView(note: note)
                    } label: {
                        VStack (alignment: .leading) {
                            Text(note.title ?? "No title")
                                .font(.title3)
                                .fontWeight(.bold)
                            if ((note.content) != "") {
                                Text(note.content ?? "No note")
                                    .opacity(0.5)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            Text(note.timestamp!, formatter: itemFormatter)
                                .font(.footnote)
                        }
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else {return}
                    viewContext.delete(notes[index])
                    try? viewContext.save()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newNote = Note(context: viewContext)
                        newNote.id = UUID()
                        newNote.title = "Nouvelle note"
                        newNote.content = ""
                        newNote.timestamp = Date()
                        try? viewContext.save()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            //.listStyle(PlainListStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationTitle("Notes")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

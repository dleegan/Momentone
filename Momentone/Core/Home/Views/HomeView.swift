//
//  HomeView.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI
import CoreData

class NotesViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [NoteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Momentone")
        container.loadPersistentStores { (description, error) in
            if let printableError = error {
                print("Error Loading Core Data \(printableError)")
            }
        }
        fetchNotes()
    }
    
    func fetchNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addNote(text: String) {
        let newNote = NoteEntity(context: container.viewContext)
        newNote.timestamp = Date()
        newNote.note = ""
        newNote.title = text
        saveData()
    }
    
    func updateNote(entity: NoteEntity, newNote: String) {
        //let currentNote = entity.note ?? ""
        //let newNote = currentNote + "!"
        entity.note = newNote
        entity.timestamp = Date()
        saveData()
    }
    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let enntity = savedEntities[index]
        container.viewContext.delete(enntity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchNotes()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

struct HomeView: View {
    @StateObject var vm = NotesViewModel()
    @State var textFieldText: String = ""
    @State var textNote: String = ""
    
    var body: some View {
        VStack (spacing: 20) {
//            TextField("Search Text...", text: $textFieldText)
//                .padding()
//                .background(.gray.opacity(0.1))
//                .cornerRadius(10)
//
//            Button {
//                guard !textFieldText.isEmpty else {return}
//                vm.addNote(text: textFieldText)
//                textFieldText = ""
//            } label: {
//                Text("Save")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical)
//                    .background(Color(.blue))
//                    .cornerRadius(10)
//            }
            
            List {
                ForEach (vm.savedEntities) { entity in
                    NavigationLink {
                        VStack () {
                            Text(entity.title ?? "No title")
                                .fontWeight(.bold)
                            Text(entity.timestamp!, formatter: itemFormatter)
                            TextEditor(text: $textNote)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .onAppear {
                            //print(entity.note ?? "no note")
                            textNote = entity.note ?? ""
                        }
                        .onDisappear {
                            //print("Vous revenez à la page précédente. Texte saisi : \($textNote)")
                            vm.updateNote(entity: entity, newNote: textNote)
                            textNote = ""
                        }
                    } label: {
                        VStack (alignment: .leading) {
                            Text(entity.title ?? "No title")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(entity.note ?? "No note")
                                .opacity(0.5)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text(entity.timestamp!, formatter: itemFormatter)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        //guard !textFieldText.isEmpty else {return}
                        vm.addNote(text: "Note")
                        textFieldText = ""
                    } label:  {
                        Label("Add Item", systemImage: "plus")
                    }                }
            }
            .listStyle(PlainListStyle())
            
        }
        .padding()
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
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

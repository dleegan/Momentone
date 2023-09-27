//
//  HomeView.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Note.timestamp, order: .reverse)], animation: .default) private var notes: [Note]
    
    @State var textFieldText: String = ""
    @State var showEdit: Bool = false
    
    
    var body: some View {
        NavigationSplitView {
            VStack () {
                List {
                    ForEach (notes) { note in
                        NavigationLink {
                            EditView(note: note)
                        } label: {
                            VStack (alignment: .leading) {
                                Text(note.title )
                                    .font(.title3)
                                    .fontWeight(.bold)
                                if ((note.content) != "") {
                                    Text(note.content )
                                        .opacity(0.5)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                                Text(note.timestamp, formatter: itemFormatter)
                                    .font(.footnote)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showEdit.toggle()
                        }, label: {
                            Label("Add Item", systemImage: "plus")
                        })
                        .navigationDestination(isPresented: $showEdit) {
                            let newNote = Note(title: "", content: "", timestamp: Date())
                            EditView(note: newNote)
                                .onDisappear {
                                    modelContext.insert(newNote)
                                }
                        }
                    }
                }
                //.listStyle(PlainListStyle())
            }
        } detail: {
        }
    }
    
    private func addItem() {
        let newNote = Note(title: "", content: "", timestamp: Date())
        withAnimation {
            modelContext.insert(newNote)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Note.self, inMemory: true)
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

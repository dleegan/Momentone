//
//  NoteView.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI

struct NoteView: View {
    //var noteInfo: NoteEntity

    var body: some View {
        VStack (alignment: .leading) {
            //Text(noteInfo.title ?? "No title")
            //Text(noteInfo.note ?? "No note")
            //Text(noteInfo.timestamp!, formatter: itemFormatter)
            Spacer()
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoteView()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

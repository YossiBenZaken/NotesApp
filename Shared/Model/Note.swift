//
//  Note.swift
//  Notes (iOS)
//
//  Created by Yosef Ben Zaken on 19/08/2022.
//

import SwiftUI

struct Note:Identifiable {
	var id = UUID().uuidString
	var note: String
	var date: Date
	var cardColor: Color
}

func getSampleDate(offset: Int) -> Date {
	let calendar = Calendar.current
	let date = calendar.date(byAdding: .day, value: offset, to: Date())
	return date ?? Date()
}

var notes: [Note] = [
	Note(note: "Note 1", date: getSampleDate(offset: 1), cardColor: Color("Skin")),
	Note(note: "Note 2", date: getSampleDate(offset: -10), cardColor: Color("Purple")),
	Note(note: "Note 3", date: getSampleDate(offset: -15), cardColor: Color("Green")),
	Note(note: "Note 4", date: getSampleDate(offset: 10), cardColor: Color("Blue")),
	Note(note: "Note 5", date: getSampleDate(offset: -3), cardColor: Color("Orange"))
]

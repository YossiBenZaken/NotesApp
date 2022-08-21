//
//  Note.swift
//  Notes (iOS)
//
//  Created by Yosef Ben Zaken on 19/08/2022.
//

import SwiftUI

struct Response: Codable {
	var notes: [Note]
}

struct Note: Codable {
	var _id: String
	var note: String
	var color: String
	var date: Double
	
	var getDate: Date {
		return Date(timeIntervalSince1970: date)
	}
}
func getSampleDate(offset: Int) -> Date {
	let calendar = Calendar.current
	let date = calendar.date(byAdding: .day, value: offset, to: Date())
	return date ?? Date()
}

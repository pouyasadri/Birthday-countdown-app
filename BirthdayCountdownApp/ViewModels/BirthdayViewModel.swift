//
//  BirthdayViewModel.swift
//  BirthdayCountdownApp
//
//  Created by Pouya Sadri on 02/02/2025.
//

import SwiftUI // Importing SwiftUI framework for building the UI

// Define a class 'BirthdayViewModel' that conforms to the ObservableObject protocol
class BirthdayViewModel: ObservableObject {
	// @AppStorage stores the 'birthdays' array in UserDefaults for persistence
	@AppStorage("birthdays") private var storedBirthdays: [Birthday] = []
	// @Published property to notify views of changes
	@Published var birthdays: [Birthday] = []

	// Initializer to load birthdays when the ViewModel is created
	init() {
		loadBirthdays()
	}

	// Function to load birthdays from stored data
	private func loadBirthdays() {
		birthdays = storedBirthdays
	}

	// Function to save the current list of birthdays to storage
	private func saveBirthdays() {
		storedBirthdays = birthdays
	}

	// Function to add a new birthday
	func addBirthday(name: String, date: Date) {
		let newBirthday = Birthday(name: name, date: date) // Create a new Birthday instance
		birthdays.append(newBirthday) // Add to the list
		saveBirthdays() // Save the updated list
	}

	// Function to update an existing birthday
	func updateBirthday(_ birthday: Birthday) {
		if let index = birthdays.firstIndex(where: { $0.id == birthday.id }) {
			birthdays[index] = birthday // Update the birthday at the found index
			saveBirthdays() // Save the updated list
		}
	}

	// Function to delete birthdays at specified offsets
	func deleteBirthdays(at offsets: IndexSet) {
		birthdays.remove(atOffsets: offsets) // Remove from the list
		saveBirthdays() // Save the updated list
	}
}

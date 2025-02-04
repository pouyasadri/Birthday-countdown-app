//
//  ContentView.swift
//  BirthdayCountdownApp
//
//  Created by Pouya Sadri on 02/02/2025.
//

import SwiftUI // Importing SwiftUI framework

struct ContentView: View {
	@StateObject private var viewModel = BirthdayViewModel() // Initialize the ViewModel
	@State private var showingAddBirthday = false // State to control the display of the add birthday sheet

	var body: some View {
		NavigationView {
			List {
				// Iterate over the list of birthdays
				ForEach(viewModel.birthdays) { birthday in
					// Navigation link to edit a selected birthday
					NavigationLink(destination: EditBirthdayView(viewModel: viewModel, birthday: birthday)) {
						VStack(alignment: .leading) {
							Text(birthday.name) // Display the name
								.font(.headline)
							Text("Next birthday in \(daysUntilNextBirthday(from: birthday.date)) days 🎂") // Display countdown
								.font(.subheadline)
						}
					}
				}
				.onDelete(perform: viewModel.deleteBirthdays) // Enable swipe to delete
			}
			.navigationTitle("Birthdays 🥳") // Set the navigation title
			.toolbar {
				// Edit button for deleting entries
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
				// Add button to show the add birthday sheet
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: { showingAddBirthday = true }) {
						Image(systemName: "plus")
					}
				}
			}
			.sheet(isPresented: $showingAddBirthday) {
				AddBirthdayView(viewModel: viewModel) // Present the add birthday view
			}
		}
	}

	// Function to calculate days until the next birthday
	private func daysUntilNextBirthday(from date: Date) -> Int {
		let calendar = Calendar.current
		let now = Date()
		let currentYear = calendar.component(.year, from: now)
		var nextBirthdayComponents = calendar.dateComponents([.day, .month], from: date)
		nextBirthdayComponents.year = currentYear

		if let nextBirthday = calendar.date(from: nextBirthdayComponents),
		   nextBirthday >= now {
			return calendar.dateComponents([.day], from: now, to: nextBirthday).day ?? 0
		} else {
			nextBirthdayComponents.year! += 1
			let nextBirthday = calendar.date(from: nextBirthdayComponents)!
			return calendar.dateComponents([.day], from: now, to: nextBirthday).day ?? 0
		}
	}
}


struct AddBirthdayView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var viewModel: BirthdayViewModel
	@State private var name = ""
	@State private var date = Date()

	var body: some View {
		NavigationView {
			Form {
				TextField("Name", text: $name)
				DatePicker("Date", selection: $date, displayedComponents: .date)
			}
			.navigationTitle("Add Birthday")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						viewModel.addBirthday(name: name, date: date)
						presentationMode.wrappedValue.dismiss()
					}
				}
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						presentationMode.wrappedValue.dismiss()
					}
				}
			}
		}
	}
}

struct EditBirthdayView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var viewModel: BirthdayViewModel
	@State var birthday: Birthday

	var body: some View {
		Form {
			TextField("Name", text: $birthday.name)
			DatePicker("Date", selection: $birthday.date, displayedComponents: .date)
		}
		.navigationTitle("Edit Birthday")
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button("Save") {
					viewModel.updateBirthday(birthday)
					presentationMode.wrappedValue.dismiss()
				}
			}
		}
	}
}

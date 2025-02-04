//
//  Birthday.swift
//  BirthdayCountdownApp
//
//  Created by Pouya Sadri on 02/02/2025.
//

import Foundation // Importing the Foundation framework for basic data types and utilities

// Define a struct named 'Birthday' that conforms to Codable and Identifiable protocols
struct Birthday: Codable, Identifiable {
	var id = UUID() // Unique identifier for each birthday entry
	var name: String // Name associated with the birthday
	var date: Date // Date of the birthday
}


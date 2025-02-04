//
//  Array.swift
//  BirthdayCountdownApp
//
//  Created by Pouya Sadri on 03/02/2025.
//

import Foundation // Import the Foundation framework for data handling

// Extend Array to conform to RawRepresentable when its elements are Codable
extension Array: RawRepresentable where Element: Codable {
	// Initialize an Array from a rawValue, which is a JSON string
	public init?(rawValue: String) {
		// Attempt to convert the rawValue (a JSON string) into Data
		guard let data = rawValue.data(using: .utf8) else {
			return nil // Return nil if the string cannot be converted to Data
		}
		// Attempt to decode the Data into an array of the specified Element type
		guard let result = try? JSONDecoder().decode([Element].self, from: data) else {
			return nil // Return nil if decoding fails
		}
		self = result // Assign the decoded array to self
	}

	// Convert the Array into a rawValue, which is a JSON string
	public var rawValue: String {
		// Attempt to encode the array into Data
		guard let data = try? JSONEncoder().encode(self) else {
			return "[]" // Return an empty JSON array string if encoding fails
		}
		// Attempt to convert the Data into a UTF-8 encoded string
		return String(data: data, encoding: .utf8) ?? "[]" // Return the JSON string or an empty array string if conversion fails
	}
}


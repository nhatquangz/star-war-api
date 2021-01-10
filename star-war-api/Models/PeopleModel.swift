//
//  PeopleModel.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation

struct PersonModel: Codable {
	let name, height, mass, hairColor: String
	let skinColor, eyeColor, birthYear, gender: String
	let homeworld: String
	let films: [String]
//	let species, vehicles: [JSONAny]
	let starships: [String]
	let created, edited: String
	let url: String

	enum CodingKeys: String, CodingKey {
		case name, height, mass
		case hairColor = "hair_color"
		case skinColor = "skin_color"
		case eyeColor = "eye_color"
		case birthYear = "birth_year"
		case gender, homeworld, films, starships, created, edited, url
	}
}

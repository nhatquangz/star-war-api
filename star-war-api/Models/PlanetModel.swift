//
//  PlanetModel.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation

struct PlanetModel: Codable {
	let name, rotationPeriod, orbitalPeriod, diameter: String
	let climate, gravity, terrain, surfaceWater: String
	let population: String
	let residents, films: [String]
	let created, edited: String
	let url: String

	enum CodingKeys: String, CodingKey {
		case name
		case rotationPeriod = "rotation_period"
		case orbitalPeriod = "orbital_period"
		case diameter, climate, gravity, terrain
		case surfaceWater = "surface_water"
		case population, residents, films, created, edited, url
	}
}

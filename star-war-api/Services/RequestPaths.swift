//
//  RequestPaths.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation

enum RequestPath: String {
	case people = "people"
	case planets = "planets"
	case starships = "starships"
	
	var url: String {
		let base = "https://swapi.dev/api/"
		return "\(base)\(self.rawValue)"
	}
}

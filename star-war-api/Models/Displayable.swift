//
//  Displayable.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit

protocol Displayable {
	var title: String { get }
	var subtitle: String { get }
	var icon: UIImage? { get }
}

extension PersonModel: Displayable {
	var title: String {
		return name
	}
	
	var subtitle: String {
		return "Birth Year: \(birthYear)"
	}
	
	var icon: UIImage? {
		return StarWarsResources.people.icon
	}
}


extension PlanetModel: Displayable {
	var title: String {
		return name
	}
	
	var subtitle: String {
		return "Climate: \(climate)"
	}
	
	var icon: UIImage? {
		return StarWarsResources.planet.icon
	}
}


extension StarshipModel: Displayable {
	var title: String {
		return name
	}
	
	var subtitle: String {
		return "Model: \(model)"
	}
	
	var icon: UIImage? {
		return StarWarsResources.starship.icon
	}
}

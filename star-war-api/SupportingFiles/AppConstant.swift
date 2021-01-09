//
//  AppConstant.swift
//  star-war-api
//
//  Created by nhatquangz on 08/01/2021.
//

import Foundation
import UIKit

enum StarWarsResources: CaseIterable {
	case people, planet, starship
	
	var title: String {
		switch self {
		case .people:
			return "people"
		case .planet:
			return "planets"
		case .starship:
			return "starships"
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .people:
			return UIImage(named: "people-icon")
		case .planet:
			return UIImage(named: "planet-icon")
		case .starship:
			return UIImage(named: "starship-icon")
		}
	}
	
	var background: UIImage? {
		switch self {
		case .people:
			return UIImage(named: "starwar-1")
		case .planet:
			return UIImage(named: "starwar-3")
		case .starship:
			return UIImage(named: "starwar-2")
		}
	}
	
	var color: UIColor {
		switch self {
		case .people:
			return UIColor.white
		case .planet:
			return UIColor(hex: "#B2322F")
		case .starship:
			return UIColor(hex: "#FFDC44")
		}
	}
}

//
//  DetailViewModel.swift
//  star-war-api
//
//  Created by nhatquangz on 10/01/2021.
//

import Foundation
import RxSwift
import RxCocoa


class DetailViewModel {
	
	let item: Displayable
	let resourceType: StarWarsResources
	
	init(item: Displayable) {
		self.item = item
		switch item {
		case is PersonModel:
			resourceType = .people
		case is PlanetModel:
			resourceType = .planet
		case is StarshipModel:
			resourceType = .starship
		default:
			resourceType = .people
		}
	}
	
}

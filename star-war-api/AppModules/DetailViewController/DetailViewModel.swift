//
//  DetailViewModel.swift
//  star-war-api
//
//  Created by nhatquangz on 10/01/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt


class DetailViewModel {
	
	let disposeBag = DisposeBag()
	
	let item: Displayable
	var resourceType: StarWarsResources = .people
	
	let generalInformation = BehaviorRelay<[String]>(value: [])
	
	var listSectionName: String?
	let listSection = BehaviorRelay<[Displayable]>(value: [])
	
	init(item: Displayable) {
		self.item = item
		
		var information: [String] = []
		if let data = item as? PersonModel {
			information = ["Height: \(data.height)",
						   "Mass: \(data.mass)",
						   "Hair Color: \(data.hairColor)",
						   "Skin Color: \(data.skinColor)",
						   "Eye Color: \(data.eyeColor)",
						   "Birth Year: \(data.birthYear)",
						   "Gender: \(data.gender)"]
			resourceType = .people
			if data.starships.count > 0 {
				listSectionName = "Starships"
				get(resources: data.starships, of: .starship)
			}
			
		} else if let data = item as? PlanetModel {
			information = ["Rotation Period: \(data.rotationPeriod)",
						   "Orbital Period: \(data.orbitalPeriod)",
						   "Diameter: \(data.diameter)",
						   "Climate: \(data.climate)",
						   "Graviry: \(data.gravity)",
						   "Terrain: \(data.terrain)",
						   "Surface Water: \(data.surfaceWater)",
						   "Population: \(data.population)"]
			resourceType = .planet
			if data.residents.count > 0 {
				listSectionName = "Residents"
				get(resources: data.residents, of: .people)
			}
			
		} else if let data = item as? StarshipModel {
			information = ["Model: \(data.model)",
						   "Manufacturer: \(data.manufacturer)",
						   "Cost In Credits: \(data.costInCredits)",
						   "Length: \(data.length)",
						   "Max Atmostphering Speed: \(data.maxAtmospheringSpeed)",
						   "Crew: \(data.crew)",
						   "Passengers: \(data.passengers)",
						   "Cargo Capacity: \(data.cargoCapacity)",
						   "Consumables: \(data.consumables)",
						   "Hyperdrive Rating: \(data.hyperdriveRating)",
						   "Mglt: \(data.mglt)",
						   "Starship Class: \(data.starshipClass)"]
			resourceType = .starship
		}
		
		generalInformation.accept(information)
	}
	
	/// asynchronous requests to get resources
	private func get(resources urls: [String], of type: StarWarsResources) {
		let observables: [Observable<Result<Displayable, Error>>] = urls.map { url in
			switch type {
			case .people:
				return AppRequest(url).request(PersonModel.self)
					.map { $0.map { $0 as Displayable } }
					.catchErrorJustComplete()
				
			case .planet:
				return AppRequest(url).request(PlanetModel.self)
					.map { $0.map { $0 as Displayable } }
					.catchErrorJustComplete()
				
			case .starship:
				return AppRequest(url).request(StarshipModel.self)
					.map { $0.map { $0 as Displayable } }
					.catchErrorJustComplete()
			}
		}
		
		Observable.from(observables).merge()
			.subscribe(onNext: { [weak self] result in
				/// Add result to list
				if let item = try? result.get() {
					var items = self?.listSection.value ?? []
					items.append(item)
					self?.listSection.accept(items)
					print(item.title)
				}
			}, onCompleted: {
				
			})
			.disposed(by: disposeBag)
	}
	
}

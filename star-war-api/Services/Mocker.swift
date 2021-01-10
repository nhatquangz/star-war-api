//
//  Mocker.swift
//  star-war-api
//
//  Created by nhatquangz on 10/01/2021.
//

import Foundation
import Alamofire
import Mocker

class MockedNetwork {
	
	static let sessionManager: Session = {
		let configuration = URLSessionConfiguration.af.default
		configuration.protocolClasses = [MockingURLProtocol.self]
		return Session(configuration: configuration)
	}()
	
	init() {
		/// Mock list
		let urls = RequestPath.allCases.map { URL(string: $0.url)! }
		let mockedData = Dictionary(uniqueKeysWithValues: zip(urls, MockedData.list))
		mockedData.map {
			Mock(url: $0.key, dataType: .json, statusCode: 200, data: [.get: $0.value])
		}
		.forEach {
			$0.register()
		}
		
		// Mock item
		let ids = Array(1...100)
		for id in ids {
			let mockedPerson = Mock(url: URL(string: "\(RequestPath.people.url)/\(id)/")!, dataType: .json, statusCode: 200, data: [.get: MockedData.person])
			mockedPerson.register()
			
//			let mockedPlanet = Mock(url: URL(string: "\(RequestPath.planets.url)/\(id)/")!, dataType: .json, statusCode: 200, data: [.get: MockedData.planet])
//			mockedPlanet.register()
			
			let mockedStarship = Mock(url: URL(string: "\(RequestPath.starships.url)/\(id)/")!, dataType: .json, statusCode: 200, data: [.get: MockedData.starship])
			mockedStarship.register()
		}
		
	}
}

public final class MockedData {
	
	static let list: [Data] = {
		let resource = ["people", "planets", "starships"]
		return resource.map { Bundle(for: MockedData.self).url(forResource: $0, withExtension: "json")!.data }
	}()
	
	public static let person: Data = Bundle(for: MockedData.self).url(forResource: "person", withExtension: "json")!.data

//	public static let planet: Data = Bundle(for: MockedData.self).url(forResource: "planet", withExtension: "json")!.data

	public static let starship: Data = Bundle(for: MockedData.self).url(forResource: "starship", withExtension: "json")!.data
}

extension URL {
	var data: Data {
		return try! Data(contentsOf: self)
	}
}

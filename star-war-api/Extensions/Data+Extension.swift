//
//  Data+Extension.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation

extension Data {
	func decoded<T: Decodable>() throws -> T {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return try decoder.decode(T.self, from: self)
	}
}

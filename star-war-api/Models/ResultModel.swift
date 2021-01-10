//
//  ResultModel.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation

struct ResultModel<T: Codable>: Codable {
	
	let next: String?
	let count: Int
	let all: [T]

	enum CodingKeys: String, CodingKey {
	  case count, next
	  case all = "results"
	}
}

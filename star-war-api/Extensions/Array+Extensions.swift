//
//  Array+Extensions.swift
//  star-war-api
//
//  Created by nhatquangz on 10/01/2021.
//

import Foundation

extension Array {
	public subscript(safe index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}
		return self[index]
	}
}

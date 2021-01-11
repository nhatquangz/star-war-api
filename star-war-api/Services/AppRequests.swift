//
//  AppRequests.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire


class AppRequest {
	
	private(set) var url: String
	private(set) var method: HTTPMethod = .get
	private(set) var parameters: [String: Any]?
	
	static private let session: Session = {
		let manager = ServerTrustManager(allHostsMustBeEvaluated: false,
										 evaluators: ["swapi.dev": DisabledTrustEvaluator()])
		return Session(serverTrustManager: manager)
	}()
	
	init(_ url: String) {
		self.url = url
	}
	
	init(_ requestPath: RequestPath) {
		self.url = requestPath.url
	}
	
	func setURL(_ url: String) -> AppRequest {
		self.url = url
		return self
	}
	
	func setMethod(_ method: HTTPMethod) -> AppRequest {
		self.method = method
		return self
	}
	
	func setParameters(_ param: [String: Any]) -> AppRequest {
		self.parameters = param
		return self
	}
	
	func request<T>(_ type: T.Type? = nil) -> Observable<Result<T, Error>> where T: Decodable {
		return Observable<Result<T, Error>>.create { observer -> Disposable in
			AF.request(self.url, parameters: self.parameters)
				.validate()
				.responseDecodable(of: T.self) { (response) in
					switch response.result {
					case .success(let value):
						observer.onNext(.success(value))
					case .failure(let error):
						observer.onError(error)
					}
					observer.onCompleted()
				}
			return Disposables.create()
		}
		.catchError { (error) -> Observable<Result<T, Error>> in
			return Observable.just(.failure(error))
		}
	}
}

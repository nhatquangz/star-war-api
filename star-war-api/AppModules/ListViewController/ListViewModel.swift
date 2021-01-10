//
//  ListViewModel.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import RxSwift
import RxCocoa


class ListViewModel {
	
	typealias ResultData = (items: [Displayable], nextPage: String?)
	
	let dataSource = BehaviorRelay<[Displayable]>(value: [])
	
	let disposeBag = DisposeBag()
	let loadData = PublishSubject<Void>()
	let refreshData = PublishSubject<Void>()
	let refreshView = PublishSubject<Void>()
	
	/// nextPage = nil: no more page
	/// nextPage = "": first page
	private var nextPage: String? = ""
	
	init(resourceType: StarWarsResources) {
		loadData.asObserver()
			.throttle(.seconds(2), scheduler: MainScheduler.instance)
			.flatMapLatest { [weak self] _ -> Observable<Result<ResultData, Error>> in
				guard let self = self else { return Observable.empty() }
				return self.getResources(resourceType)
			}
			.subscribe(onNext: { [weak self] result in
				guard let self = self else { return }
				if let data = try? result.get() {
					/// Reset data if users refresh view
					if self.nextPage == "" {
						self.dataSource.accept([])
					}
					/// Update nextPage
					self.nextPage = data.nextPage
					
					/// Add new data
					var newData = self.dataSource.value
					newData.append(contentsOf: data.items)
					self.dataSource.accept(newData)
					self.refreshView.onNext(())
				}
			})
			.disposed(by: disposeBag)
		
		refreshData.asObserver()
			.throttle(.seconds(3), scheduler: MainScheduler.instance)
			.do(onNext: { [weak self] _ in
				/// Reset page
				self?.nextPage = ""
			})
			.bind(to: loadData)
			.disposed(by: disposeBag)
	}
}


extension ListViewModel {
	func getResources(_ type: StarWarsResources) -> Observable<Result<ResultData, Error>> {
		
		/// No more page to load if nextpage = nil
		guard nextPage != nil else { return Observable.empty() }
		
		switch type {
		case .people:
			let url = (nextPage != "") ? nextPage! : RequestPath.people.url
			return AppRequest(url).request(ResultModel<PersonModel>.self)
				.map { $0.map { ($0.all as [Displayable], $0.next) } }
			
		case .planet:
			let url = (nextPage != "") ? nextPage! : RequestPath.planets.url
			return AppRequest(url).request(ResultModel<PlanetModel>.self)
				.map { $0.map { ($0.all as [Displayable], $0.next) } }
			
		case .starship:
			let url = (nextPage != "") ? nextPage! : RequestPath.starships.url
			return AppRequest(url).request(ResultModel<StarshipModel>.self)
				.map { $0.map { ($0.all as [Displayable], $0.next) } }
		}
	}
}

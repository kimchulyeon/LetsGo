//
//  LocationSearchRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift
import MapKit

class LocationSearchRepository {
    private let bag = DisposeBag()
    private let locationSearchdatasource = LocationSearchDatasource()
    
    func searchLocationWithKeyword(_ query: String) -> Observable<[Location]> {
        return locationSearchdatasource.searchLocationWithKeyword(query)
            .flatMap({ result -> Observable<[Location]> in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(SearchedLocationWithKeywordResponse.self, from: data)
                        let dto = response.documents
                        let locations = dto.compactMap { $0.toDomain() }
                        return .just(locations)
                    } catch {
                        return .error(error)
                    }
                case .failure(let error):
                    return .error(error)
                }
            })
    }
    
    
    func searchLocationWithAddress(_ query: String) -> Observable<[Location]> {
        return locationSearchdatasource.searchLocationWithAddress(query)
            .flatMap({ result -> Observable<[Location]> in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(SearchedLocationWithAddressResponse.self, from: data)
                        let dto = response.documents
                        let locations = dto.compactMap { $0.toDomain() }
                        return .just(locations)
                    } catch {
                        return .error(error)
                    }
                case .failure(let error):
                    return .error(error)
                }
            })
    }
}

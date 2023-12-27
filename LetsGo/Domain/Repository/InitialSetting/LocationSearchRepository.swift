//
//  LocationSearchRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift
import MapKit

class LocationSearchRepository: LocationSearchRepositoryProtocol {
    // MARK: - properties
    private let bag = DisposeBag()
    private let locationSearchdatasource: LocationSearchDatasourceProtocol
    
    // MARK: - lifecycle
    init(locationSearchdatasource: LocationSearchDatasourceProtocol?) {
        self.locationSearchdatasource = locationSearchdatasource!
    }
    
    // MARK: - method
    /// 키워드로 장소 검색
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
    
    /// 주소로 장소 검색
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

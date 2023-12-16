//
//  LocationUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import MapKit
import RxSwift

class LocationUseCase: LocationUseCaseProtocol {
    // MARK: - properties
    private let locationRepository: LocationSearchRepositoryProtocol
    
    // MARK: - lifecycle
    init(locationRepository: LocationSearchRepositoryProtocol) {
        self.locationRepository = locationRepository
    }
    
    // MARK: - method
    func locationSearch(type: SearchType, query: String) -> Observable<[Location]> {
        switch type {
            
        case .keyword:
            return locationRepository.searchLocationWithKeyword(query)
        case .address:
            return locationRepository.searchLocationWithAddress(query)
        }
        
    }
}


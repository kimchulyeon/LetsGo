//
//  LocationUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import MapKit
import RxSwift

class LocationUseCase {
    private let locationRepository = LocationSearchRepository()
    
    func locationSearch(type: SearchType, query: String) -> Observable<[Location]> {
        switch type {
            
        case .keyword:
            return locationRepository.searchLocationWithKeyword(query)
        case .address:
            return locationRepository.searchLocationWithAddress(query)
        }
        
    }
}


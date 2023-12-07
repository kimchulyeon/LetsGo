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
    
    func locationSearch(query: String) -> Observable<[Location]> {
        return locationRepository.searchLocationWithKeyword(query)
    }
}

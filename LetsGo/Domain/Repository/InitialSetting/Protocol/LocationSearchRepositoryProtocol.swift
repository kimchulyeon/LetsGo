//
//  LocationSearchRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift

protocol LocationSearchRepositoryProtocol {
    func searchLocationWithKeyword(_ query: String) -> Observable<[Location]>
    
    func searchLocationWithAddress(_ query: String) -> Observable<[Location]>
}

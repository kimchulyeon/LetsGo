//
//  LocationUseCaseProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift

protocol LocationUseCaseProtocol {
    func locationSearch(type: SearchType, query: String) -> Observable<[Location]>
}

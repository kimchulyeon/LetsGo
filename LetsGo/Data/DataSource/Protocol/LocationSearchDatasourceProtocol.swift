//
//  LocationSearchDatasourceProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift

protocol LocationSearchDatasourceProtocol {
    func searchLocationWithKeyword(_ query: String) -> Observable<Result<Data, NetworkError>>
    
    func searchLocationWithAddress(_ query: String) -> Observable<Result<Data, NetworkError>>
}

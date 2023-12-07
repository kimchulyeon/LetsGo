//
//  LocationSearchDatasource.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import MapKit
import RxSwift

class LocationSearchDatasource: LocationSearchDatasourceProtocol {
    
    private let urlsessionService = URLSessionService()

    /// 키워드로 장소 검색
    func searchLocationWithKeyword(_ query: String) -> Observable<Result<Data, NetworkError>> {
        
        return urlsessionService.request(urlString: .kakao,
                                  urlPath: .kakaoLocationSearchWithKeyword,
                                  method: .get,
                                  headers: ["Authorization": "KakaoAK 623b1302ef889c06586c7583464dc69d"],
                                  queryString: ["page": "1", "size": "15", "sort": "accuracy", "query": query])
    }
    
    /// 주소로 장소 검색
    func searchLocationWithAddress(_ query: String) -> Observable<Result<Data, NetworkError>> {
        return urlsessionService.request(urlString: .kakao,
                                         urlPath: .kakaoLocationSearchWithAddress,
                                         method: .get,
                                         headers: ["Authorization": "KakaoAK 623b1302ef889c06586c7583464dc69d"],
                                         queryString: ["page": "1", "size": "15", "analyze_type": "similar", "query": query])
    }

}

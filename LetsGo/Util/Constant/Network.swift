//
//  BaseURL.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation

enum BaseURL: String {
    case kakao = "https://dapi.kakao.com/v2"
}

enum URLPath: String {
    case kakaoLocationSearchWithKeyword = "local/search/keyword.json"
    case kakaoLocationSearchWithAddress = "local/search/address.json"
}

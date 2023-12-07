//
//  SearchedLocationDTO.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation

struct SearchedLocationWithKeywordResponse: Codable {
    let documents: [SearchedLocationWithKeywordDTO]
    let meta: KeyWordLocationSearchMeta
}

// MARK: - Document
struct SearchedLocationWithKeywordDTO: Codable {
    let addressName, categoryGroupCode, categoryGroupName, categoryName: String?
    let distance, id, phone, placeName: String?
    let placeURL: String?
    let roadAddressName, x, y: String?

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
    }
    
    // ENTITY로 변환
    func toDomain() -> Location {
        return Location(id: id, address: addressName, placeName: placeName, x: x, y: y, phone: phone, category: categoryGroupName)
    }
}

struct KeyWordLocationSearchMeta: Codable {
    let isEnd: Bool?
    let pageableCount: Int?
    let sameName: KeywordLocationSameName?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case sameName = "same_name"
        case totalCount = "total_count"
    }
}

struct KeywordLocationSameName: Codable {
    let keyword: String?
    let region: [String]?
    let selectedRegion: String?

    enum CodingKeys: String, CodingKey {
        case keyword, region
        case selectedRegion = "selected_region"
    }
}


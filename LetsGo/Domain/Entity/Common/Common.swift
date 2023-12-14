//
//  Common.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation

/// 교통수단 타입
enum Transportation: String, CaseIterable {
    case walk = "도보"
    case `public` = "대중교통"
    case car = "자동차"
    case bike = "자전거"
    case none = ""
    
    var emoji: String {
        switch self {
        case .walk:
            "🦶"
        case .public:
            "🚇"
        case .car:
            "🚘"
        case .bike:
            "🚴"
        case .none:
            ""
        }
    }
}

/// 요일
enum DayOfWeek: String, CaseIterable {
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thu = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
}

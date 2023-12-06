//
//  Common.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation

/// 교통수단 타입
enum Transportation: Int, CaseIterable {
    case walk
    case pulic
    case car
    case bike
    case none
}

/// 요일
enum DayOfWeek: Int, CaseIterable {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
}

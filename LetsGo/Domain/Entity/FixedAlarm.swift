//
//  FixedAlarm.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation
import CoreLocation

struct FixedAlarm: Equatable {
    let id: UUID = UUID()
    let createdAt: Date = Date()
    let transportationType: Transportation   // 교통수단
    let departureLocation: CLLocation        // 출발지
    let destinationLocation: CLLocation      // 도착지
    let days: [DayOfWeek]                     // 선택 요일
    let arriveHour: Int                       // 도착 시
    let arriveMinute: Int                     // 도착 분
    let floatTime: Int                        // 도착까지 여유 시간
}




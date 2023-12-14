//
//  FixedAlarm.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation
import CoreLocation

struct Alarm: Equatable {
    let id: UUID = UUID()
    let isOn: Bool = true
    let alarmTitme: String
    let createdAt: Date = Date()
    let transportationType: Transportation   // 교통수단
    let departureKeyword: String?            // 출발지 키워드
    let departureAddress: String?            // 출발지 주소
    let departureLocation: CLLocation        // 출발지 좌표
    
    let destinationKeyword: String?          // 도착지 키워드
    let destinationAddress: String?          // 도착지 주소
    let destinationLocation: CLLocation      // 도착지 좌표
    let days: [DayOfWeek]                     // 선택 요일
    let arriveHour: Int                       // 도착 시
    let arriveMinute: Int                     // 도착 분
    let floatTime: Int                        // 도착까지 여유 시간
}




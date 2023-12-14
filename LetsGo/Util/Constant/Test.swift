//
//  Test.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/14/23.
//

import Foundation
import CoreLocation

struct Test {
    static let alarmList: [Alarm] = [
        Alarm(alarmTitme: "등산하러 가기",
              transportationType: .bike,
              departurePlaceName: "코엑스",
              destinationPlaceName: "자양로 50길",
              departureLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              destinationLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              days: [.mon, .tue, .wed],
              arriveHour: 19,
              arriveMinute: 30,
              floatTime: 15),
        
        Alarm(alarmTitme: "아차산가기",
              transportationType: .public,
              departurePlaceName: "선릉로 9, 219-3002",
              destinationPlaceName: "몽골식당",
              departureLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              destinationLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              days: [.sat, .sun],
              arriveHour: 10,
              arriveMinute: 10,
              floatTime: 15),
        
        Alarm(alarmTitme: "쇼핑하기",
              transportationType: .walk,
              departurePlaceName: "롯데백화점",
              destinationPlaceName: "잠실역",
              departureLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              destinationLocation: CLLocation(latitude: 37.413294, longitude: 127.269311),
              days: [.thu, .fri],
              arriveHour: 15,
              arriveMinute: 50,
              floatTime: 15),
    ]
}

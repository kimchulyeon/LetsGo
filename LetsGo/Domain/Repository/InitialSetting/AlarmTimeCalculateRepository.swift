//
//  AlarmTimeCalculateRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import Foundation
import MapKit

class AlarmTimeCalculateRepository: AlarmTimeCalculateRepositoryProtocol {
    // MARK: - properties

    // MARK: - method
    func calculateAlarmTime(with alarm: Alarm) {
        let request = MKDirections.Request()
        guard let start_location = alarm.departureLocation,
            let end_location = alarm.destinationLocation,
            let start_x = start_location.x,
            let start_y = start_location.y,
            let end_x = end_location.x,
            let end_y = end_location.y else { return }

        let start_lati = Double(start_y)!
        let start_long = Double(start_x)!
        let end_lati = Double(end_y)!
        let end_long = Double(end_x)!

        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: start_lati, longitude: start_long)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: end_lati, longitude: end_long)))
        request.transportType = .walking // .walking, .transit, .automobile 중 선택

        let directions = MKDirections(request: request)
        print(directions)
        directions.calculate { (response, error) in
            guard let route = response?.routes.first else { return }
            print("예상 여행 시간: \(route.expectedTravelTime) 초")
        }
    }
}
    
/**
 화면에 거리 표시
 사용자한테 출발 시간을 입력 받는거로 수정
 도착시간 입력 받는걸 출발 시간 입력 받는거로 수정
 경로 보기 버튼 => 기본 지도 앱 | 카카오맵 앱 열어서 경로 그려주기
 1. 경로를 다른 앱으로 보고 걸리는 시간을 확인하고 출발 시간 입력 받기
 2. 그냥 바로 출발 시간 입력 받기
 */

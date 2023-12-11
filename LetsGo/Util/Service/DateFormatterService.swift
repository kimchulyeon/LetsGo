//
//  DateFormatterService.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import Foundation

class DateFormatterService {
    static func formatDateToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
}

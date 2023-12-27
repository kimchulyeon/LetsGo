//
//  InitialSettingUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import Foundation

class InitialSettingUseCase: InitialSettingUseCaseProtocol {
    // MARK: - properties
    private let alarmTimeCalculateRepository: AlarmTimeCalculateRepositoryProtocol
    
    // MARK: - lifecycle
    init(alarmTimeCalculateRepository: AlarmTimeCalculateRepositoryProtocol) {
        self.alarmTimeCalculateRepository = alarmTimeCalculateRepository
    }
    
    // MARK: - method
    func calculateAlarmTime() {
        alarmTimeCalculateRepository.calculateAlarmTime()
    }
}

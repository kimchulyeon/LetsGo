//
//  AlarmTableCell.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import UIKit
import SnapKit

class AlarmTableCell: UITableViewCell {
    //MARK: - properties
    static let identifier = "alarmTableCell"
    private let containerView: UIView = {
        let v = UIView()
        v.addCornerRadius(radius: 12)
        v.backgroundColor = .white
        return v
    }()
    private let weekButtonHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    private let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = ThemeColor.weakRed
        return btn
    }()
    private let timeLabel : UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.bold(size: 36)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let alarmToggle: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    private let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColor.moreLightGray
        return v
    }()
    private let showRouteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("경로 보기", for: .normal)
        btn.setTitleColor(ThemeColor.weakPrimary, for: .normal)
        btn.titleLabel?.font = ThemeFont.demiBold(size: 12)
       return btn
   }()
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(weekButtonHStackView)
        DayOfWeek.allCases.forEach { weekCase in
            let week = weekCase.rawValue
            let button = WeekButtonView(title: week)
            weekButtonHStackView.addArrangedSubview(button)
        }
        weekButtonHStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(14)
        }
        
        containerView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(weekButtonHStackView.snp.trailing).offset(16)
            make.height.width.equalTo(14)
        }
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(weekButtonHStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
        }
        
        containerView.addSubview(alarmToggle)
        alarmToggle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.leading.greaterThanOrEqualTo(timeLabel.snp.trailing).offset(16)
        }
        
        containerView.addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        containerView.addSubview(showRouteButton)
        showRouteButton.snp.makeConstraints { make in
            make.top.equalTo(dividerLineView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    func configure() {
        selectionStyle = .none
        timeLabel.text = "11:30"
    }
}

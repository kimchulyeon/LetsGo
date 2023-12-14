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
        v.layer.shadowColor = ThemeColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowOpacity = 0.4
        v.layer.masksToBounds = false
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
        lb.font = ThemeFont.demiBold(size: 30)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let transportationLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 24)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let alarmToggle: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = ThemeColor.primary
        return sw
    }()
    private let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColor.moreLightGray
        return v
    }()
    private let departureLabel: UILabel = {
        let lb = UILabel()
        lb.text = "TEST"
        lb.font = ThemeFont.regular(size: 12)
        lb.textColor = ThemeColor.moreWeakText
        return lb
    }()
    private let destinationLabel: UILabel = {
        let lb = UILabel()
        lb.text = "TEST"
        lb.font = ThemeFont.regular(size: 12)
        lb.textColor = ThemeColor.moreWeakText
        return lb
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
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.addSubview(weekButtonHStackView)
        DayOfWeek.allCases.forEach { weekCase in
            let week = weekCase.rawValue
            let button = MarkingWeekView(title: week)
            weekButtonHStackView.addArrangedSubview(button)
        }
        weekButtonHStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(14)
        }
        
        containerView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(weekButtonHStackView.snp.top)
            make.bottom.equalTo(weekButtonHStackView.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(weekButtonHStackView.snp.trailing).offset(16)
            make.width.equalTo(deleteButton.snp.height)
        }
        
        containerView.addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { make in
            make.top.equalTo(weekButtonHStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerLineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
        }
        
        containerView.addSubview(transportationLabel)
        transportationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.leading.equalTo(timeLabel.snp.trailing).offset(8)
        }
        
        containerView.addSubview(alarmToggle)
        alarmToggle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.leading.greaterThanOrEqualTo(transportationLabel.snp.trailing).offset(8)
        }
        
        containerView.addSubview(departureLabel)
        departureLabel.snp.makeConstraints { make in
            make.leading.equalTo(weekButtonHStackView.snp.leading)
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.addSubview(destinationLabel)
        destinationLabel.snp.makeConstraints { make in
            make.trailing.equalTo(deleteButton.snp.trailing)
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with data: Alarm) {
        selectionStyle = .none
        
        let timeText = "\(data.arriveHour) : \(data.arriveMinute) 까지"
        let attributedString = NSMutableAttributedString(string: timeText)
        guard let range = timeText.range(of: "까지") else { return }
        let nsRange = NSRange(range, in: timeText)
        attributedString.addAttributes([.font: ThemeFont.demiBold(size: 14), .foregroundColor: ThemeColor.weakText], range: nsRange)
        timeLabel.attributedText = attributedString
        
        let transportationText = "\(data.transportationType.emoji) 로"
        let t_attributedString = NSMutableAttributedString(string: transportationText)
        guard let range = transportationText.range(of: "로") else { return }
        let t_nsRange = NSRange(range, in: transportationText)
        t_attributedString.addAttributes([.font: ThemeFont.demiBold(size: 14)], range: t_nsRange)
        transportationLabel.attributedText = t_attributedString
        
        alarmToggle.isOn = data.isOn
        
        data.days.forEach { weekCase in
            weekButtonHStackView.arrangedSubviews.forEach { view in
                guard let v = view as? MarkingWeekView else { return }
                
                if v.containerButtonView.titleLabel?.text == weekCase.rawValue {
                    v.containerButtonView.backgroundColor = ThemeColor.weakPrimary
                }
            }
        }
    }
}

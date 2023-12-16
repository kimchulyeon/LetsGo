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
        v.backgroundColor = ThemeColor.greenPrimary
        return v
    }()
    private let weekButtonHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = ThemeColor.weakText
        btn.showsMenuAsPrimaryAction = true
        btn.menu = setupMoreButtonMenu()
        return btn
    }()
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 13)
        lb.textColor = ThemeColor.weakText
        return lb
    }()
    private let timeLabel : UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.bold(size: 30)
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
        sw.onTintColor = ThemeColor.blackPrimary
        return sw
    }()
    private let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColor.moreWeakText
        return v
    }()
    private let departureLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 11)
        lb.textColor = ThemeColor.moreWeakText
        return lb
    }()
    private let destinationLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 11)
        lb.textColor = ThemeColor.weakText
        lb.textAlignment = .right
        return lb
    }()
    private lazy var labelHStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [departureLabel, destinationLabel])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
        nameLabel.text = nil
        transportationLabel.text = nil
        alarmToggle.isOn = true
        departureLabel.text = nil
        destinationLabel.text = nil
        weekButtonHStackView.arrangedSubviews.forEach { view in
            guard let v = view as? MarkingWeekView else { return }
            v.backgroundColor = nil
        }
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.addSubview(weekButtonHStackView)
        weekButtonHStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(14)
        }
        DayOfWeek.allCases.forEach { weekCase in
            let week = weekCase.rawValue
            let button = MarkingWeekView(title: week)
            weekButtonHStackView.addArrangedSubview(button)
        }
        
        containerView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(weekButtonHStackView.snp.top)
            make.bottom.equalTo(weekButtonHStackView.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(weekButtonHStackView.snp.trailing).offset(16)
            make.width.equalTo(moreButton.snp.height)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(weekButtonHStackView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
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
        
        containerView.addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { make in
            make.top.equalTo(alarmToggle.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(1)
        }
        
        containerView.addSubview(labelHStackView)
        labelHStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.top.equalTo(dividerLineView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    private func setupMoreButtonMenu() -> UIMenu {
        let deleteAction = UIAction(title: "삭제하기", image: UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), handler: { _ in print("DELETE >>>> ")})
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [deleteAction])
        return menu
    }
    
    func configure(with data: Alarm) {
        selectionStyle = .none
        
        let timeText = "\(data.arriveHour) : \(data.arriveMinute) 까지"
        let attributedString = NSMutableAttributedString(string: timeText)
        guard let range = timeText.range(of: "까지") else { return }
        let nsRange = NSRange(range, in: timeText)
        attributedString.addAttributes([.font: ThemeFont.demiBold(size: 14), .foregroundColor: ThemeColor.moreWeakText], range: nsRange)
        timeLabel.attributedText = attributedString
        
        nameLabel.text = data.alarmTitme
        
        let transportationText = "\(data.transportationType.emoji) 로"
        let t_attributedString = NSMutableAttributedString(string: transportationText)
        guard let range = transportationText.range(of: "로") else { return }
        let t_nsRange = NSRange(range, in: transportationText)
        t_attributedString.addAttributes([.font: ThemeFont.demiBold(size: 14), .foregroundColor: ThemeColor.moreWeakText], range: t_nsRange)
        transportationLabel.attributedText = t_attributedString
        
        alarmToggle.isOn = data.isOn
        
        departureLabel.text = data.departurePlaceName
        destinationLabel.text = data.destinationPlaceName
        
        data.days.forEach { weekCase in
            weekButtonHStackView.arrangedSubviews.forEach { view in
                guard let v = view as? MarkingWeekView else { return }
                
                if v.roundedButton.titleLabel?.text == weekCase.rawValue {
                    v.roundedButton.backgroundColor = ThemeColor.blackPrimary
                }
            }
        }
    }
}

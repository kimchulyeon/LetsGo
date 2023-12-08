//
//  LocationCell.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit
import SnapKit

class LocationCell: UITableViewCell {
    //MARK: - properties
    static let identifier = "locationCell"
    
    private let placeNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 18)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let topInfoView = LocationCellInfoView()
    private let bottomInfoView = LocationCellInfoView()
    private lazy var infoViewStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [topInfoView, bottomInfoView])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 3
        return sv
    }()
    
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(placeNameLabel)
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(infoViewStackView)
        infoViewStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(placeNameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func updateUI(with location: Location) {
        let IS_KEYWORD = location.placeName != nil
        IS_KEYWORD ? setupKeywordInfoView(with: location) : setupAddressInfoView(with: location)
        topInfoView.updateUI(with: BadgeType.address, and: location)
    }
    
    private func setupKeywordInfoView(with location: Location) {
//        placeNameLabel.isHidden = false
        placeNameLabel.text = location.placeName
        bottomInfoView.updateUI(with: BadgeType.phoneNumber, and: location)
    }
    
    private func setupAddressInfoView(with location: Location) {
//        placeNameLabel.isHidden = true
        bottomInfoView.updateUI(with: BadgeType.postNumber, and: location)
    }
}

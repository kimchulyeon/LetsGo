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
    private let weekButtonHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    private let timeLabel : UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - method
}

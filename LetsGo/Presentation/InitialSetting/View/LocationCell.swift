//
//  LocationCell.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit

class LocationCell: UITableViewCell {
    //MARK: - properties
    
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
        
    }
}

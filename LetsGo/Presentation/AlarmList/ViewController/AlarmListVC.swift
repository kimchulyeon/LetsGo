//
//  AlarmListVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AlarmListVC: UIViewController {
    //MARK: - properties
    private let bag = DisposeBag()
    private let viewModel: AlarmListVM
    
    let test = Observable.just([1, 2, 3, 4, 5])
    
    private let alarmTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.register(AlarmTableCell.self, forCellReuseIdentifier: AlarmTableCell.identifier)
        return tv
    }()
    
    //MARK: - Lifecycle
    init(viewModel: AlarmListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        testTableView()
    }
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = ThemeColor.background
        
        navigationItem.title = "알람"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: ThemeColor.text, .font: ThemeFont.demiBold(size: 28)]
        
        view.addSubview(alarmTableView)
        alarmTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func testTableView() {
        test.bind(to: alarmTableView.rx.items) { tableView, row, data in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableCell.identifier) as? AlarmTableCell else { return UITableViewCell() }
            cell.configure()
            return cell
        }
        .disposed(by: bag)
    }
}

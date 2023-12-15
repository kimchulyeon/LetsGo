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
    
    private let alarmTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.register(AlarmTableCell.self, forCellReuseIdentifier: AlarmTableCell.identifier)
        return tv
    }()
    private let addAlarmButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = ThemeColor.yellow
        return btn
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
        bindViewModel()
    }
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = ThemeColor.background
        
        #warning("네비게이션 configureation 배경색 / 타이틀 색 일치 시키기")
        navigationItem.title = "알람"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: ThemeColor.text,
                                                                        .font: ThemeFont.demiBold(size: 28)]
        
        view.addSubview(alarmTableView)
        alarmTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        alarmTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(addAlarmButton)
        addAlarmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-13)
            make.height.width.equalTo(50)
        }
        addAlarmButton.addCornerRadius(radius: 25)
    }
    
    private func bindViewModel() {
        let input = AlarmListVM.Input(addButtonTapped: addAlarmButton.rx.tap.asObservable(),
                                      alarmTapped: alarmTableView.rx.modelSelected(Alarm.self).asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.alarmList
            .bind(to: alarmTableView.rx.items) { tableView, row, data in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableCell.identifier) as? AlarmTableCell else { return UITableViewCell() }
                cell.configure(with: data)
                return cell
            }
            .disposed(by: bag)
        
        output.addButtonTapped
            .withUnretained(self)
            .subscribe { (self, _) in
                let viewModel = ComposeAlarmVM()
                let composeAlarmVC = ComposeAlarmVC(viewModel: viewModel)
                self.navigationController?.present(composeAlarmVC, animated: true)
            }
            .disposed(by: bag)
    }
}

//
//  DepartureSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DepartureSettingVC: UIViewController {
    //MARK: - properties
    private let viewModel: DepartureSettingVM
    private let bag = DisposeBag()

    private let titleLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 23, color: ThemeColor.text)
        lb.text = "출발지 설정"
        return lb
    }()
    private let descLabel: UILabel = {
        let lb = LabelFactory.basicLabel()
        lb.text = "시간 측정을 위해 출발지를 설정해주세요"
        return lb
    }()
    private let searchTypeButtonView = SearchTypeButtonView()
    private let searchTextField = SearchTextField()
    private let locationTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = ThemeColor.lightGray
        return tv
    }()

    //MARK: - Lifecycle
    init(viewModel: DepartureSettingVM) {
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

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }

        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }

        view.addSubview(searchTypeButtonView)
        searchTypeButtonView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(descLabel.snp.bottom).offset(16)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(searchTypeButtonView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        view.addSubview(locationTableView)
        locationTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
        }
    }

    private func bindViewModel() {
        let searchTypeButtonObservable = Observable<SearchType>.create { [unowned self] emitter in
            let keywordDisposable = searchTypeButtonView.keywordButton.rx.tap
                .subscribe(onNext: {
                emitter.onNext(.keyword)
            })

            let addressDisposable = searchTypeButtonView.addressButton.rx.tap
                .subscribe(onNext: {
                emitter.onNext(.address)
            })

            return Disposables.create(keywordDisposable, addressDisposable)
        }

        let input = DepartureSettingVM.Input(inputTextField: searchTextField.textField.rx.text.orEmpty.asObservable(),
                                             searchTypeButtonTapped: searchTypeButtonObservable)
        let output = viewModel.transform(input: input)

        output.searchedLocationLists
            .subscribe { locations in
                print("리스트 : \(locations)")
            }
            .disposed(by: bag)
//            .bind(to: locationTableView.rx.items) { tableview, row, element in
//            #warning("테이블뷰 셀 구성")
//            let cell = tableview.dequeueReusableCell(withIdentifier: "locationCell") as! LocationCell
//                cell.configure(elemen)
//            return cell
//        }
            

        output.buttonType
            .subscribe { [unowned self] type in
                searchTextField.textField.text = nil
                updateSearchTypeButton(type: type)
            }
            .disposed(by: bag)
    }

    private func updateSearchTypeButton(type: SearchType) {
        resetSearchTypeButton()
        switch type {
        case .keyword:
            searchTypeButtonView.keywordButton.backgroundColor = ThemeColor.primary
            searchTypeButtonView.keywordButton.setTitleColor(.white, for: .normal)
        case .address:
            searchTypeButtonView.addressButton.backgroundColor = ThemeColor.primary
            searchTypeButtonView.addressButton.setTitleColor(.white, for: .normal)
        }
    }

    private func resetSearchTypeButton() {
        searchTypeButtonView.keywordButton.backgroundColor = .clear
        searchTypeButtonView.keywordButton.setTitleColor(ThemeColor.text, for: .normal)
        searchTypeButtonView.addressButton.backgroundColor = .clear
        searchTypeButtonView.addressButton.setTitleColor(ThemeColor.text, for: .normal)
    }
}


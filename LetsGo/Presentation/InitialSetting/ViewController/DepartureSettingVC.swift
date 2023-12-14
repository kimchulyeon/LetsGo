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
        let lb = LabelFactory.basicLabel(font: .regular, size: 14, color: ThemeColor.weakText)
        lb.text = "시간 측정을 위해 출발지를 설정해주세요"
        return lb
    }()
    private let searchTypeButtonView = SearchTypeButtonView()
    private let searchTextField = SettingTextField()
    private let locationTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(LocationCell.self, forCellReuseIdentifier: LocationCell.identifier)
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        searchTextField.textField.endEditing(true)
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
            make.height.equalTo(45)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(searchTypeButtonView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        view.addSubview(locationTableView)
        locationTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
        }
    }

    private func bindViewModel() {
        let searchTypeButtonObservable: Observable<SearchType> = setupTypeButtonTapObservable()

        let input = DepartureSettingVM.Input(inputTextField: searchTextField.textField.rx.text.orEmpty.asObservable(),
                                             searchTypeButtonTapped: searchTypeButtonObservable)
        let output = viewModel.transform(input: input)

        hideTableViewDependsOnListCount(output: output)
        setupSearchResultTableView(output: output)
        updateTypeButton(output: output)
        setupTableViewSelectEvent(output: output)
    }
    
    private func setupTypeButtonTapObservable() -> Observable<SearchType> {
        return Observable<SearchType>.create { [unowned self] emitter in
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
    }
    
    private func hideTableViewDependsOnListCount(output: DepartureSettingVM.Output) {
        output.searchedLocationLists
            .observe(on: MainScheduler.instance)
            .subscribe { [unowned self] list in
                guard let locationList = list.element else { return }
                if locationList.isEmpty {
                    locationTableView.isHidden = true
                    return
                }
                locationTableView.isHidden = false
            }
            .disposed(by: bag)
    }
    
    private func setupSearchResultTableView(output: DepartureSettingVM.Output) {
        output.searchedLocationLists
            .bind(to: locationTableView.rx.items) { tableview, row, locationData in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationCell.identifier) as? LocationCell else { return UITableViewCell() }
                cell.updateUI(with: locationData)
                return cell
            }
            .disposed(by: bag)
    }
    
    private func updateTypeButton(output: DepartureSettingVM.Output) {
        output.buttonType
            .subscribe { [unowned self] type in
                resetSearch()
                
                switch type {
                case .keyword:
                    searchTextField.textField.placeholder = "키워드를 입력해주세요"
                    searchTypeButtonView.keywordButton.backgroundColor = ThemeColor.primary
                    searchTypeButtonView.keywordButton.setTitleColor(.white, for: .normal)
                case .address:
                    searchTextField.textField.placeholder = "주소를 입력해주세요"
                    searchTypeButtonView.addressButton.backgroundColor = ThemeColor.primary
                    searchTypeButtonView.addressButton.setTitleColor(.white, for: .normal)
                }
            }
            .disposed(by: bag)
    }
    
    private func setupTableViewSelectEvent(output: DepartureSettingVM.Output) {
        locationTableView.rx.itemSelected
           .subscribe(onNext: { [unowned self] indexPath in
               searchTextField.textField.endEditing(true)
               let selectedLocation = output.searchedLocationLists.value[indexPath.row]
               locationTableView.deselectRow(at: indexPath, animated: true)
               
               presentBottomSheet(with: output, and: selectedLocation)
           })
           .disposed(by: bag)
    }

    private func resetSearch() {
        searchTextField.textField.text = nil
        searchTypeButtonView.keywordButton.backgroundColor = .clear
        searchTypeButtonView.keywordButton.setTitleColor(ThemeColor.moreWeakText, for: .normal)
        searchTypeButtonView.addressButton.backgroundColor = .clear
        searchTypeButtonView.addressButton.setTitleColor(ThemeColor.moreWeakText, for: .normal)
    }
    
    private func presentBottomSheet(with output: DepartureSettingVM.Output, and selectedLocation: Location) {
        let bottomSheetViewModel = ConfirmBottomSheetVM()
        let bottomSheetVC = ConfirmBottomSheetVC(viewModel: bottomSheetViewModel)
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        
        bottomSheetVC.updateSelectedLocation(selectedLocation)
        bottomSheetVC.updateUI(with: selectedLocation, and: output.buttonType.value)
        present(bottomSheetVC, animated: true)
    }
}


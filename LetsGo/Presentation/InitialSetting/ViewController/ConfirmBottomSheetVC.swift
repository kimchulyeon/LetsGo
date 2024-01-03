//
//  ConfirmBottomSheetVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/8/23.
//

import UIKit
import SnapKit
import RxSwift

class ConfirmBottomSheetVC: UIViewController {
    //MARK: - properties
    private let viewModel: ConfirmBottomSheetVM
    private let bag = DisposeBag()
    
    private let dimmedView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return v
    }()
    private let bottomSheetView = BottomSheetView()
    private var bottomSheetViewBottomConstraint: Constraint!

    //MARK: - Lifecycle
    init(viewModel: ConfirmBottomSheetVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animateBottomSheet()
        bindViewModel()
    }

    //MARK: - method
    private func setupUI() {
        view.backgroundColor = .clear

        view.addSubview(dimmedView)
        view.sendSubviewToBack(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(230)
            self.bottomSheetViewBottomConstraint = make.bottom.equalToSuperview().offset(230).constraint
        }
    }

    private func animateBottomSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            self.bottomSheetViewBottomConstraint.update(offset: 0)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func bindViewModel() {
        let cancelButtonTapObservable = bottomSheetView.cancelButton.rx.tap.asObservable()
        let confirmButtonTapObservable = bottomSheetView.confirmButton.rx.tap.asObservable()
         
        let input = ConfirmBottomSheetVM.Input(cancelButtonTapped: cancelButtonTapObservable,
                                               confirmButtonTapped: confirmButtonTapObservable)
        
        let output = viewModel.transform(input: input)
        
        output.dismissBottomSheet
            .subscribe { [weak self] location in
                guard let weakSelf = self else { return }
                
                if let presentingVC = weakSelf.presentingViewController as? InitialSettingsPageVC {
                    presentingVC.goToNextPage()
                }
                
                weakSelf.dismiss(animated: true)
            }
            .disposed(by: bag)
        
    }
    
    func updateUI(with location: Location, and buttonType: SearchType) {
        bottomSheetView.updateUI(with: location, and: buttonType)
    }
    
    func updateSelectedLocation(_ location: Location) {
        viewModel.selectedLocation.onNext(location)
    }
}

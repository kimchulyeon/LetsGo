//
//  InitialSettingsPageViewController.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import UIKit
import RxSwift

class InitialSettingsPageVC: UIPageViewController {
    //MARK: - properties
    private let bag = DisposeBag()
    private let viewModel: InitialSettingsPageVM

    //MARK: - lifecycle
    init(viewModel: InitialSettingsPageVM) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
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

    }

    private func bindViewModel() {
        viewModel.currentPage
            .subscribe { [unowned self] page in
                let viewController = viewModel.viewControllerForPage(page)
                setViewControllers([viewController], direction: .forward, animated: true)
            }
            .disposed(by: bag)
    }
    
    func goToNextPage() {
        viewModel.goToNextPage()
    }
}

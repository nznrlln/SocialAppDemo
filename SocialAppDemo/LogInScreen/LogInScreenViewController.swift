//
//  LogInScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.03.2023.
//

import UIKit
import SnapKit

class LogInScreenViewController: UIViewController {

    private lazy var mainView: LogInScreenView = {
        let view = LogInScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }



}

// MARK: - LogInScreenViewDelegate
extension LogInScreenViewController: LogInScreenViewDelegate {
    func confirmButtonTapAction() {
        //
    }
}

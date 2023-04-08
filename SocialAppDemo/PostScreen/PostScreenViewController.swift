//
//  PostViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit
import SnapKit

class PostScreenViewController: UIViewController {

    private lazy var mainView: PostScreenView = {
        let view = PostScreenView()
        view.toAutoLayout()

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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


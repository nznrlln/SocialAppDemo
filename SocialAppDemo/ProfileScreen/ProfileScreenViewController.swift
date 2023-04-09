//
//  ProfileScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 08.04.2023.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    private lazy var mainView: ProfileScreenView = {
        let view = ProfileScreenView()
        view.toAutoLayout()
//        view.delegate = self

        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white
        self.title = "Profile".localizable
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
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

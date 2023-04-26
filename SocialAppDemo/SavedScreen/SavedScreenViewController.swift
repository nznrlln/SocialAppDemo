//
//  SavedScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 09.04.2023.
//

import UIKit

class SavedScreenViewController: UIViewController {

    private lazy var mainView: SavedScreenView = {
        let view = SavedScreenView()
        view.toAutoLayout()
//        view.delegate = self

        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white
        self.title = "Saved".localizable
        self.tabBarItem.image = UIImage(systemName: "bookmark")

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

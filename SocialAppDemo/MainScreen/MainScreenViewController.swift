//
//  HomeScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    private lazy var mainView: MainScreenView = {
        let view = MainScreenView()
        view.toAutoLayout()
        view.delegate = self

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
        self.title = "Main".localizable
        self.tabBarItem.image = UIImage(systemName: "house")


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


// MARK: - MainScreenViewDelegate

extension MainScreenViewController: MainScreenViewDelegate {
    func didSelectPost() {
        let postVC = PostScreenViewController()

        self.navigationController!.pushViewController(postVC, animated: true)
    }


}

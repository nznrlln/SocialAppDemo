//
//  ProfileScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 08.04.2023.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    private let model: ProfileScreenDataModel

    private let mainView: ProfileScreenView

    init(model: ProfileScreenDataModel, mainView: ProfileScreenView) {
        self.mainView = mainView
        self.model = model

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//        self.title = "Profile".localizable
//        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        setupModels()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupModels() {
        model.delegate = self
        model.getModelData()

        mainView.delegate = self
        mainView.toAutoLayout()
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

// MARK: - ProfileScreenDataModelDelegate

extension ProfileScreenViewController: ProfileScreenDataModelDelegate {
    func modelUpdatedProfileData() {
        mainView.updateProfile()
    }
    
    func modelUpdatedPhotos() {
        mainView.updatePhotos()
    }
    
    func modelUpdatedPosts() {
        mainView.updatePosts()
    }
    

}

// MARK: - ProfileScreenDataModelDelegate

extension ProfileScreenViewController: ProfileScreenViewDelegate {

    var user: UserModel {
        model.profileData
    }
    
    var images: [UIImage] {
        model.userPhotos
    }
    
    var posts: [String? : [PostModel]] {
        model.userPosts
    }
    
    var postsDates: [String] {
        model.postsDates
    }


    func didSelectPost(post: PostModel, author: UserModel) {
        let model = PostScreenModel(post: post, author: author)
        let view = PostScreenView()
        let vc = PostScreenViewController(model: model, mainView: view)

        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

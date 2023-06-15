//
//  ProfileScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 08.04.2023.
//

import UIKit
import SnapKit

class ProfileScreenViewController: UIViewController {

    weak var coordinator: GeneralContentCoordinator?

    private let model: ProfileScreenModel

    private lazy var mainView: ProfileScreenView = {
        let view = ProfileScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    init(model: ProfileScreenModel) {
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

        setupModels()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupModels() {
        model.delegate = self
        model.getModelData()
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

// MARK: - ProfileScreenModelDelegate

extension ProfileScreenViewController: ProfileScreenModelDelegate {
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

    func didTapDetails() {
      //  
    }

    func didSelectPhoto() {
        coordinator?.openPhotos()
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        coordinator?.openPost(post: post, author: author)
    }

    func didSaveTap(post: PostModel, author: UserModel) {
        let exists = CoreDataManager.shared.postCheck(postUID: post.postUID)

        if exists {
            CoreDataManager.shared.deletePost(postUID: post.postUID)
        } else {
            CoreDataManager.shared.addPost(post: post, author: author)
        }
    }
}

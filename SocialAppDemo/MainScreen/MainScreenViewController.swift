//
//  HomeScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    private let model: MainScreenModel

    private let mainView: MainScreenView

    init(model: MainScreenModel, mainView: MainScreenView) {
        self.model = model
        self.mainView = mainView

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
//        self.title = "Main".localizable
//        self.tabBarItem.image = UIImage(systemName: "house")


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

// MARK: - MainScreenModelDelegate
extension MainScreenViewController: MainScreenModelDelegate {
    func modelUpdatedUsers() {
        mainView.updateUsersView()
    }
    
    func modelUpdatedPosts() {
        mainView.updatePostsView()
    }
    

}

// MARK: - MainScreenViewDelegate

extension MainScreenViewController: MainScreenViewDelegate {

    var users: [UserModel] {
        model.usersCollection
    }

    var posts: [String?: [PostModel]] {
        model.postsCollection
    }

    var postsDates: [String] {
        model.postsDates
    }

    func didSelectUser(userUID: String) {
        let model = ProfileScreenDataModel(profileUID: userUID)
        let view = ProfileScreenView()
        let vc = ProfileScreenViewController(model: model, mainView: view)
        navigationController?.pushViewController(vc, animated: true)
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        let model = PostScreenModel(post: post, author: author)
        let view = PostScreenView()
        let vc = PostScreenViewController(model: model, mainView: view)

        self.navigationController!.pushViewController(vc, animated: true)
    }


}

//
//  HomeScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {

    weak var coordinator: MainCoordinatorProtocol?

    private let model: MainScreenModel

    private lazy var mainView: MainScreenView = {
        let view = MainScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    init(model: MainScreenModel) {
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
        view.backgroundColor = Palette.mainBackground

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

    func didSelectStory(story: UIImage, cell: UserStoryCollectionViewCell, xOffset: CGFloat) {
        coordinator?.openStory(story: story, cell: cell, xOffset: xOffset)
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

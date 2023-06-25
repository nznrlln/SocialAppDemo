//
//  PostViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit
import SnapKit

final class PostScreenViewController: UIViewController {

    weak var coordinator: GeneralContentCoordinator?

    private let model: PostScreenModel

    private lazy var mainView: PostScreenView = {
        let view = PostScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    init(model: PostScreenModel) {
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

    private func viewInitialSettings() {
        view.backgroundColor = Palette.mainBackground
        self.navigationController!.navigationBar.isHidden = false

        setupModels()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupModels() {
        mainView.setupView()
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

// MARK: - PostScreenDelegate
extension PostScreenViewController: PostScreenDelegate {

    var post: PostModel {
        model.post
    }
    var author: UserModel {
        model.author
    }

    func didPressUser() {
        coordinator?.openProfile(profileUID: author.userUID)
    }

    func saveButtonTapAction() {
        let exists = CoreDataManager.shared.postCheck(postUID: model.post.postUID)

        if exists {
            CoreDataManager.shared.deletePost(postUID: model.post.postUID)
        } else {
            CoreDataManager.shared.addPost(post: model.post, author: model.author)
        }
    }
}

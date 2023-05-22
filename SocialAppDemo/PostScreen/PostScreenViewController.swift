//
//  PostViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit
import SnapKit

class PostScreenViewController: UIViewController {

    private let model: PostScreenModel

    private let mainView: PostScreenView

    init(model: PostScreenModel, mainView: PostScreenView) {
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

    private func viewInitialSettings() {
        view.backgroundColor = .white
        self.navigationController!.navigationBar.isHidden = false

        setupModels()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupModels() {
        mainView.delegate = self
        mainView.toAutoLayout()
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
        let model = ProfileScreenModel(profileUID: author.userUID)
        let view = ProfileScreenView()
        let vc = ProfileScreenViewController(model: model, mainView: view)
        navigationController?.pushViewController(vc, animated: true)
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

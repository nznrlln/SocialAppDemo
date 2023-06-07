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

    // для анимации - знать какую сториз открыли
    private var selectedStoryCell: UserStoryCollectionViewCell?
    private var selectedCellSnapshot: UIView?
    private var animator: CircularAnimator?

    private var selectedCellXOffset: CGFloat?

    // точка начала анимации - центр ячейки сториз
    private var startingAnimationPoint: CGPoint {
        guard let cellCenterPoint = self.selectedStoryCell?.center,
              let cellXOffset = self.selectedCellXOffset,
              let navBarYOffset = self.navigationController?.navigationBar.frame.origin.y,
              let navBarHeight = self.navigationController?.navigationBar.frame.height
        else { return .zero }

        return CGPoint(
            x: cellCenterPoint.x - cellXOffset + MainScreenALConstants.collectionSideInset,
            y: cellCenterPoint.y + navBarHeight + navBarYOffset - MainScreenALConstants.collectionTopInset
        )
    }


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

    func didSelectUser(user: UserModel, cell: UserStoryCollectionViewCell, xOffset: CGFloat) {
        // записали, какая ячейка была выбрана
        self.selectedStoryCell = cell
        self.selectedCellSnapshot = self.selectedStoryCell?.contentView.snapshotView(afterScreenUpdates: false)
        self.selectedCellXOffset = xOffset

        let vc = StoryScreenViewController()
        vc.setupStory(model: user)
        // говорим, что переход будет кастомный
        // и что делегатом анимации для открытия сториз будем мы сами
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true)
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        let model = PostScreenModel(post: post, author: author)
        let view = PostScreenView()
        let vc = PostScreenViewController(model: model, mainView: view)

        self.navigationController!.pushViewController(vc, animated: true)
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

// MARK: - MainScreenViewDelegate

extension MainScreenViewController: UIViewControllerTransitioningDelegate {

    // контроллер анимации для показа
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator = CircularAnimator(
            duration: 0.5,
            circleColor: self.selectedStoryCell?.backgroundColor ?? .systemYellow,
            selectedCellSnapshot: self.selectedCellSnapshot
        )
        self.animator?.setup(
            usingTransitionMode: .present,
            andStartingPoint: self.startingAnimationPoint
        )

        return self.animator
    }

    // контроллер анимации для скрытия
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator?.setup(
            usingTransitionMode: .dismiss,
            andStartingPoint: self.startingAnimationPoint
        )

        return self.animator
    }
}

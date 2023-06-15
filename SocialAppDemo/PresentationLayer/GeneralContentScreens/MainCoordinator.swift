//
//  MainCoordinator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 11.06.2023.
//

import UIKit

protocol MainCoordinatorProtocol: GeneralContentCoordinator {
    func openStory(story: UIImage, cell: UserStoryCollectionViewCell, xOffset: CGFloat)
}

class MainCoordinator: NSObject, MainCoordinatorProtocol {
    var navigationController: UINavigationController

    // для анимации - знать какую сториз открыли
    private var selectedStoryCell: UserStoryCollectionViewCell?
    private var selectedCellSnapshot: UIView?
    private var animator: CircularAnimator?

    private var selectedCellXOffset: CGFloat?

    private lazy var navBarYOffset = self.navigationController.navigationBar.frame.origin.y
    private lazy var navBarHeight = self.navigationController.navigationBar.frame.height

    // точка начала анимации - центр ячейки сториз
    private var startingAnimationPoint: CGPoint {
        guard let cellCenterPoint = self.selectedStoryCell?.center,
              let cellXOffset = self.selectedCellXOffset
        else { return .zero }

        return CGPoint(
            x: cellCenterPoint.x - cellXOffset + MainScreenALConstants.collectionSideInset,
            y: cellCenterPoint.y + navBarHeight + navBarYOffset - MainScreenALConstants.collectionTopInset
        )
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = Palette.darkButton
    }

    func start() {
        let model = MainScreenModel()
        let controller = MainScreenViewController(model: model)
        controller.coordinator = self

        navigationController.tabBarItem.title = "main".localizable
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([controller], animated: true)
    }

    func openStory(story: UIImage, cell: UserStoryCollectionViewCell, xOffset: CGFloat) {
        // записали, какая ячейка была выбрана
        self.selectedStoryCell = cell
        self.selectedCellSnapshot = self.selectedStoryCell?.contentView.snapshotView(afterScreenUpdates: false)
        self.selectedCellXOffset = xOffset

        let controller = StoryScreenViewController()
        controller.setupStory(model: story)
        // говорим, что переход будет кастомный
        // и что делегатом анимации для открытия сториз будем мы сами
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self

        self.navigationController.present(controller, animated: true)
    }

    func openPost(post: PostModel, author: UserModel) {
        let model = PostScreenModel(post: post, author: author)
        let controller = PostScreenViewController(model: model)
        controller.coordinator = self

        self.navigationController.pushViewController(controller, animated: true)
    }

    func openProfile(profileUID: String?) {
        let model = ProfileScreenModel(profileUID: profileUID)
        let controller = ProfileScreenViewController(model: model)
        controller.coordinator = self

        self.navigationController.pushViewController(controller, animated: true)
    }

    func openPhotos() {
        let model = PhotosScreenModel()
        let controller = PhotosScreenViewController(model: model)

        self.navigationController.pushViewController(controller, animated: true)
    }
}


// MARK: - UIViewControllerTransitioningDelegate

extension MainCoordinator: UIViewControllerTransitioningDelegate {

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

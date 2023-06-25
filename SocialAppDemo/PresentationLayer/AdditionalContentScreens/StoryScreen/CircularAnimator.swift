//
//  CircularAnimator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 06.06.2023.
//

import UIKit

// класс ответственный за анимацию
// содержит все необходимое для перехода от одного эрана на другой
// наследуется от NSObject, т.к. это обязательное условие
// для реализации протокола UIViewControllerAnimatedTransitioning
final class CircularAnimator: NSObject {

    enum TransitionMode {
        case present
        case dismiss
        case none
    }

    // какая анимация нам нужна (показать/скрыть)
    private var transitionMode: TransitionMode = .none
    // длительность анимации в сек
    private let duration: CGFloat
    // начальная точка анимации
    private var startingPoint: CGPoint = .zero
    // цвет анимации
    private var circleColor: UIColor
    // снимок ячейки - чтобы знать исходные размеры
    private let selectedCellSnapshot: UIView?
    // окружность для анимации
    private var circle: UIView!


    init(
        duration: CGFloat,
        circleColor: UIColor,
        selectedCellSnapshot: UIView? = nil
    ) {
        self.duration = duration
        self.circleColor = circleColor
        self.selectedCellSnapshot = selectedCellSnapshot
    }

    func setup(
        usingTransitionMode transitionMode: TransitionMode,
        andStartingPoint startingPoint: CGPoint
    ) {
        self.transitionMode = transitionMode
        self.startingPoint = startingPoint
    }

    // метод возвращающий размер для окружности
    private func frameForCircle(
        withCenter circleCenter: CGPoint,
        viewSize: CGSize,
        startPoint: CGPoint
    ) -> CGRect {
        // fmax - Returns the maximum value of each element in a vector.
        // макс длина по осям - от границы нач.точки до границ вью
        let xLenght = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLenght = fmax(startPoint.y, viewSize.height - startPoint.y)

        // x^2 + y^2 = r^2
        // sqrt - это корень
        // offsetVector - получается это диаметр
        let offsetVector = sqrt(xLenght * xLenght + yLenght * yLenght) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)

        return CGRect(origin: .zero, size: size)
    }

}

// MARK: -UIViewControllerAnimatedTransitioning

extension CircularAnimator: UIViewControllerAnimatedTransitioning {

    // метод отвечающий за длительность перехода
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }

    // метод самой реализации перехода
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        // вью контейнера анимации - по сути КИТ сам засовывает туда вьюшки, между которыми происходит анимация (и ту и ту)
        let containerView = transitionContext.containerView

        switch transitionMode {
            // если вью, которую надо показать(.to)/скрыть(.from), существует, то продолжаем анимацию
            // если нет, то завершаем анимацию с результатом провалом
        case .present:
            guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                transitionContext.completeTransition(false)
                return
            }
            // сохраняем "родной"(конечный) центр и размер целевой вью
            let viewOriginalCenter = presentedView.center
            let viewSize = presentedView.frame.size

            // получаем конечный размеры/положение окружности
            let circleFrame = self.frameForCircle(
                withCenter: viewOriginalCenter,
                viewSize: viewSize,
                startPoint: self.startingPoint
            )
            // создаем окружность с полученным размером и настраиваем ее: радиус, центр, заливку
            self.circle = UIView(frame: circleFrame)
            self.circle.layer.cornerRadius = self.circle.frame.height / 2
            self.circle.center = self.startingPoint
            self.circle.backgroundColor = self.circleColor

            // преобразование окружности
            let circleTransform: CGAffineTransform
            // если у нас есть скрин с исходной ячейкой
            if let selectedCellSnapshot = self.selectedCellSnapshot {
                // то задаем коэф. преобразования, для получения размера окружности в начале анимации = размеру ячейки
                let scaleX = selectedCellSnapshot.frame.size.width / self.circle.frame.size.width
                let scaleY = selectedCellSnapshot.frame.size.height / self.circle.frame.size.height
                circleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            } else {
                // иначе - считаем, что размер окружности в начале анимации стремится к 0 (точка)
                circleTransform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }
            // трасформируем окружность в полученный размер и добавляем в контейнер анимации
            self.circle.transform = circleTransform
            containerView.addSubview(self.circle)

            // дельта- разница по осям между конечным размером нужного экрана и точкой старта анимации
            let delta = CGPoint(
                x: (presentedView.frame.size.width / 2 - self.startingPoint.x),
                y: (presentedView.frame.size.height / 2 - self.startingPoint.y)
            )

            // центр будущей вью = смещение от цетра окружности на дельту
            presentedView.center = CGPoint(
                x: (circleFrame.size.width / 2 + delta.x),
                y: (circleFrame.size.height / 2 + delta.y)
            )
            // скрываем будущую вью и помещаем внутрь окружности анимации
            presentedView.alpha = 0
            self.circle.addSubview(presentedView)

            // вызываем анимацию с продолжительностью, анимацией, и замыканием по окончанию
            UIView.animate(withDuration: self.duration) {
                // показываем будущую вью и возвращаем окружности родной размер (с размер вью)
                presentedView.alpha = 1
                self.circle.transform = CGAffineTransform.identity
            } completion: { finished in
                transitionContext.completeTransition(finished)
            }

        case .dismiss:
            guard let dissmissedView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                transitionContext.completeTransition(false)
                return
            }

            let viewOriginalCenter = dissmissedView.center
            let viewSize = dissmissedView.frame.size

            let circleTransform: CGAffineTransform
            if let selectedCellSnapshot = self.selectedCellSnapshot {
                let scaleX = selectedCellSnapshot.frame.size.width / self.circle.frame.size.width
                let scaleY = selectedCellSnapshot.frame.size.height / self.circle.frame.size.height
                circleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            } else {
                circleTransform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }

            self.circle.frame = self.frameForCircle(
                withCenter: viewOriginalCenter,
                viewSize: viewSize,
                startPoint: self.startingPoint
            )
            self.circle.center = self.startingPoint

            containerView.addSubview(dissmissedView)

            UIView.animate(withDuration: self.duration) {
                dissmissedView.alpha = 0
                self.circle.transform = circleTransform
            } completion: { finished in
                self.circle.removeFromSuperview()
                self.circle = nil
                transitionContext.completeTransition(finished)
            }
        case .none:
            transitionContext.completeTransition(false)
        }
    }
}

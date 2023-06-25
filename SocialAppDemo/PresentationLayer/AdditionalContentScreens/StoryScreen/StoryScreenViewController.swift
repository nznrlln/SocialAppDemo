//
//  StoryScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.06.2023.
//

import UIKit
import SnapKit

final class StoryScreenViewController: UIViewController {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()

        return imageView
    }()

    private lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.tintColor = Palette.mainAccent
        imageView.isUserInteractionEnabled = true

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    func setupStory(model: UIImage) {
        avatarImageView.image = model
    }

    private func viewInitialSettings() {
        view.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
        addGestures()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemYellow

        view.addSubviews(avatarImageView, closeImageView)
    }
    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        closeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.height.equalTo(40)
        }
    }
    private func addGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapImageView))
        closeImageView.addGestureRecognizer(gesture)
    }

    @objc private func didtapImageView() {
        self.dismiss(animated: true)
    }
    
}

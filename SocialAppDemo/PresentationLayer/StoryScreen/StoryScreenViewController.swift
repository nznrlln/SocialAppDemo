//
//  StoryScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.06.2023.
//

import UIKit
import SnapKit

class StoryScreenViewController: UIViewController {

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
        setupSubviews()
        setupSubviewsLayout()
        addGestures()
    }

    func setupStory(model: UserModel) {
        avatarImageView.image = model.avatar
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

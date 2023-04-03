//
//  PostScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 28.03.2023.
//

import UIKit

class PostScreenView: UIView {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = PostScreenALConstants.avatarHeight / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = Palette.mainAccent

        return imageView
    }()

    private let authorNicknameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.mainAccent
        label.text = "Author"

        return label
    }()

    private let authorStatusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg12
        label.textColor = Palette.secondaryText
        label.text = "Status"

        return label
    }()

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = Palette.mainAccent

        return imageView
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.numberOfLines = 0
        label.text = "With prototyping in Figma, you can create multiple flows for your prototype in one page to preview a user's full journey and experience through your designs. A flow is a path users take through the network of connected frames that make up your prototype. For example, you can create a prototype for a shopping app that includes a flow for account creation, another for browsing items, and another for the checkout process–all in one page.\nWhen you add a connection between two frames with no existing connections in your prototype, a flow starting point is created. You can create multiple flows using the same network of connected frames by adding different flow starting points."

        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "heart"), for: .normal)

        return button
    }()

    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()

    private lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "message"), for: .normal)

        return button
    }()

    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()

    private lazy var savePostButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)

        return button
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryText

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewInitialSettings() {
        self.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(avatarImageView,
                         authorNicknameLabel,
                         authorStatusLabel,
                         postImageView,
                         postDescriptionLabel,
                         likeButton, likeCountLabel,
                         commentsButton, commentsCountLabel,
                         savePostButton,
                         separatorView)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(PostScreenALConstants.avatarTopInset)
            make.leading.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
            make.height.width.equalTo(PostScreenALConstants.avatarHeight)
        }

        authorNicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(PostScreenALConstants.nicknameTopInset)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(PostScreenALConstants.generalSideInset)
        }

        authorStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(authorNicknameLabel.snp.bottom)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(PostScreenALConstants.generalSideInset)
        }

        postImageView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(PostScreenALConstants.postImageTopInset)
            make.leading.trailing.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
            make.height.equalTo(PostScreenALConstants.postImageHeight)
        }

        postDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(PostScreenALConstants.postDescriptionTopInset)
            make.leading.trailing.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
        }

        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.buttonTopInset)
            make.leading.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
        }

        likeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.countTopInset)
            make.leading.equalTo(likeButton.snp.trailing).offset(PostScreenALConstants.countSideInset)
        }

        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.countTopInset)
            make.leading.equalTo(likeCountLabel.snp.trailing).offset(PostScreenALConstants.commentButtonSideInset)
        }

        commentsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.countTopInset)
            make.leading.equalTo(commentsButton.snp.trailing).offset(PostScreenALConstants.countSideInset)
        }

        savePostButton.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.buttonTopInset)
            make.trailing.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(PostScreenALConstants.separatorTopInset)
            make.leading.trailing.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
            make.height.equalTo(PostScreenALConstants.separatorHeight)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

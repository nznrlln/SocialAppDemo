//
//  PostTableViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.04.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var saveButtonTapAction: (() -> Void)?

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true

        return imageView
    }()

    private let authorNicknameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
        label.text = "Author"

        return label
    }()

    private let authorStatusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.textColor = Palette.secondaryText
        label.text = "Status"

        return label
    }()

    private let postBodyView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondBackground

        return view

    }()

    private let verticalLineView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.blackAndWhite

        return view
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.textAlignment = .left
        label.numberOfLines = 4
//        label.text = "Обязательно вступите в группу курса в Телеграм группа PRO, вся оперативная информация там, но на первой неделе мы будем присылать рассылку о новых уроках"

        return label
    }()

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryText

        return view
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        self.tintColor = Palette.mainAccent

        return button
    }()

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()
    private lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        self.tintColor = Palette.mainAccent

        return button
    }()

    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    private lazy var savePostButton: CustomSaveButton = {
        let button = CustomSaveButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)

        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCellWith(model: PostModel?, author: UserModel?) {
        guard let model = model else { return }
        guard let author = author else { return }

        postDescriptionLabel.text = model.postText
        postImageView.image = model.postImage
        postDescriptionLabel.text = model.postText
        likesCountLabel.text = String(model.likesCount ?? 0)
        commentsCountLabel.text = String(model.commentsCount ?? 0)

        avatarImageView.image = author.avatar
        authorNicknameLabel.text = author.nickname
        authorStatusLabel.text = author.status

        savePostButton.isSaved = CoreDataManager.shared.postCheck(postUID: model.postUID)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        postDescriptionLabel.text = ""
        postImageView.image = nil
        postDescriptionLabel.text = ""

        avatarImageView.image = nil
        authorNicknameLabel.text = ""
        authorStatusLabel.text = ""
    }


    private func cellInitialSetting() {
//        self.backgroundColor = Palette.darkButton

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.contentView.addSubviews(avatarImageView,
                                     authorNicknameLabel,
                                     authorStatusLabel,
                                     postBodyView)

        postBodyView.addSubviews(verticalLineView,
                                 postDescriptionLabel,
                                 postImageView,
                                 separatorView,
                                 likeButton, likesCountLabel,
                                 commentsButton, commentsCountLabel,
                                 savePostButton)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(PostsTableViewALConstants.avatarTopInset)
            make.leading.equalToSuperview().inset(PostsTableViewALConstants.generalSideInset)
            make.height.width.equalTo(PostsTableViewALConstants.avatarHeight)
        }

        authorNicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(PostsTableViewALConstants.nicknameTopInset)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(PostsTableViewALConstants.nicknameSideInset)
        }

        authorStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(authorNicknameLabel.snp.bottom).offset(PostsTableViewALConstants.statusTopInset)
            make.leading.equalTo(authorNicknameLabel.snp.leading)
        }

        postBodyView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(PostsTableViewALConstants.postBodyTopInset)
            make.leading.trailing.bottom.equalToSuperview()
        }

        verticalLineView.snp.makeConstraints { make in
            make.top.equalTo(postBodyView.snp.top).inset(PostsTableViewALConstants.verticalLineTopInset)
            make.leading.equalTo(postBodyView.snp.leading).inset(PostsTableViewALConstants.verticalLineSideInset)
            make.bottom.equalTo(postBodyView.snp.bottom).inset(PostsTableViewALConstants.verticalLineBottomInset)
//            make.height.equalTo(HomeScreenALConstants.verticalLineHeight)
            make.width.equalTo(PostsTableViewALConstants.verticalLineWidth)
        }

        postDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postBodyView.snp.top).inset(PostsTableViewALConstants.postDescriptionTopInset)
            make.leading.equalTo(verticalLineView.snp.trailing).offset(PostsTableViewALConstants.postDescriptionSideInset)
            make.trailing.equalTo(postBodyView.snp.trailing).inset(PostsTableViewALConstants.postDescriptionSideInset)
        }

        postImageView.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostsTableViewALConstants.postImageTopInset)
            make.leading.equalTo(verticalLineView.snp.trailing).offset(PostsTableViewALConstants.postImageSideInset)
            make.trailing.equalTo(postBodyView.snp.trailing).inset(PostsTableViewALConstants.postImageSideInset)
            make.height.equalTo(PostsTableViewALConstants.postImageHeight)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(verticalLineView.snp.bottom).offset(PostsTableViewALConstants.separatorTopInset)
            make.leading.trailing.equalTo(postBodyView)
            make.height.equalTo(PostsTableViewALConstants.separatorHeight)
        }

        likeButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.buttonTopInset)
            make.leading.equalTo(postBodyView).inset(PostsTableViewALConstants.likeButtonSideInset)
        }

        likesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.countTopInset)
            make.leading.equalTo(likeButton.snp.trailing).offset(PostsTableViewALConstants.countSideInset)
        }

        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.buttonTopInset)
            make.leading.equalTo(likesCountLabel.snp.trailing).offset(PostsTableViewALConstants.commentButtonSideInset)
        }

        commentsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.countTopInset)
            make.leading.equalTo(commentsButton.snp.trailing).offset(PostsTableViewALConstants.countSideInset)
        }

        savePostButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.saveButtonTopInset)
            make.trailing.equalTo(postBodyView).inset(PostsTableViewALConstants.saveButtonSideInset)
        }
    }

    @objc private func saveButtonTap() {
        debugPrint("save tap")
        saveButtonTapAction?()
    }

}

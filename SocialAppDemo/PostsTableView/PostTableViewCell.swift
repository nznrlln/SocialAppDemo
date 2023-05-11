//
//  PostTableViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.04.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var currentPost: PostModel?
    var currentAuthor: UserModel?

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

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    lazy var savePostButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = Palette.mainAccent
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

        currentPost = model
        currentAuthor = author

        postDescriptionLabel.text = model.postText
        postImageView.image = model.postImage
        postDescriptionLabel.text = model.postText
        likesCountLabel.text = String(describing: model.likesCount)
        commentsCountLabel.text = String(describing: model.commentsCount)

        avatarImageView.image = author.avatar
        authorNicknameLabel.text = author.nickname
        authorStatusLabel.text = author.status
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        currentPost = nil
        currentAuthor = nil

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

        savePostButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(PostsTableViewALConstants.saveButtonTopInset)
            make.trailing.equalTo(postBodyView).inset(PostsTableViewALConstants.saveButtonSideInset)
        }
    }

    @objc private func saveButtonTap() {
        debugPrint("save tap")
        guard let currentPost = currentPost,
              let currentAuthor = currentAuthor else { return }
        CoreDataManager.shared.addPost(post: currentPost, author: currentAuthor)
    }

}

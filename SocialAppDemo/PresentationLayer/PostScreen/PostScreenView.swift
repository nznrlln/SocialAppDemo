//
//  PostScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 28.03.2023.
//

import UIKit

protocol PostScreenDelegate {
    var post: PostModel { get }
    var author: UserModel { get }

    func didPressUser()
    func saveButtonTapAction()
}

class PostScreenView: UIView {

    var delegate: PostScreenDelegate?

    private lazy var avaterTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    private lazy var nicknameTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = PostScreenALConstants.avatarHeight / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true

        return imageView
    }()

    private let authorNicknameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.mainAccent
        label.isUserInteractionEnabled = true
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

        return imageView
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.numberOfLines = 0

        return label
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

        return label
    }()

    lazy var savePostButton: CustomSaveButton = {
        let button = CustomSaveButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)

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

    func setupView() {
        avatarImageView.addGestureRecognizer(avaterTapGesture)
        authorNicknameLabel.addGestureRecognizer(nicknameTapGesture)

        avatarImageView.image = delegate?.author.avatar
        authorNicknameLabel.text = delegate?.author.nickname
        authorStatusLabel.text = delegate?.author.status
        postImageView.image = delegate?.post.postImage
        postDescriptionLabel.text = delegate?.post.postText
        likesCountLabel.text = String(delegate?.post.likesCount ?? 0)
        commentsCountLabel.text = String(delegate?.post.commentsCount ?? 0)
        savePostButton.isSaved = CoreDataManager.shared.postCheck(postUID: delegate?.post.postUID ?? "")
    }

    private func viewInitialSettings() {
        self.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(
            avatarImageView,
            authorNicknameLabel,
            authorStatusLabel,
            postImageView,
            postDescriptionLabel,
            likeButton, likesCountLabel,
            commentsButton, commentsCountLabel,
            savePostButton,
            separatorView
        )
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

        likesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.countTopInset)
            make.leading.equalTo(likeButton.snp.trailing).offset(PostScreenALConstants.countSideInset)
        }

        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.countTopInset)
            make.leading.equalTo(likesCountLabel.snp.trailing).offset(PostScreenALConstants.commentButtonSideInset)
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

    @objc private func tapAction() {
        delegate?.didPressUser()
    }

    @objc private func saveButtonTap() {
        debugPrint("save tap")
        delegate?.saveButtonTapAction()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

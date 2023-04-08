//
//  PostTableViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.04.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = Palette.mainAccent

        return imageView
    }()

    private let authorNicknameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
//        label.textColor = Palette.mainAccent
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
        label.text = "Обязательно вступите в группу курса в Телеграм группа PRO, вся оперативная информация там, но на первой неделе мы будем присылать рассылку о новых уроках"

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

    private let separatorView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryText

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cellInitialSetting() {
//        self.backgroundColor = Palette.darkButton

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        postBodyView.addSubviews(verticalLineView,
                                 postDescriptionLabel,
                                 postImageView,
                                 separatorView)

        self.addSubviews(avatarImageView,
                         authorNicknameLabel,
                         authorStatusLabel,
                         postBodyView)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(HomeScreenALConstants.avatarTopInset)
            make.leading.equalToSuperview().inset(HomeScreenALConstants.generalSideInset)
            make.height.width.equalTo(HomeScreenALConstants.avatarHeight)
        }

        authorNicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(HomeScreenALConstants.nicknameTopInset)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(HomeScreenALConstants.nicknameSideInset)
        }

        authorStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(authorNicknameLabel.snp.bottom).offset(HomeScreenALConstants.statusTopInset)
            make.leading.equalTo(authorNicknameLabel.snp.leading)
        }

        postBodyView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(HomeScreenALConstants.postBodyTopInset)
            make.leading.trailing.bottom.equalToSuperview()
        }

        verticalLineView.snp.makeConstraints { make in
            make.top.equalTo(postBodyView.snp.top).inset(HomeScreenALConstants.verticalLineTopInset)
            make.leading.equalTo(postBodyView.snp.leading).inset(HomeScreenALConstants.verticalLineSideInset)
            make.bottom.equalTo(postBodyView.snp.bottom).inset(HomeScreenALConstants.verticalLineBottomInset)
//            make.height.equalTo(HomeScreenALConstants.verticalLineHeight)
            make.width.equalTo(HomeScreenALConstants.verticalLineWidth)
        }

        postDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postBodyView.snp.top).inset(HomeScreenALConstants.postDescriptionTopInset)
            make.leading.equalTo(verticalLineView.snp.trailing).offset(HomeScreenALConstants.postDescriptionSideInset)
            make.trailing.equalTo(postBodyView.snp.trailing).inset(HomeScreenALConstants.postDescriptionSideInset)
        }

        postImageView.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(HomeScreenALConstants.postImageTopInset)
            make.leading.equalTo(verticalLineView.snp.trailing).offset(HomeScreenALConstants.postImageSideInset)
            make.trailing.equalTo(postBodyView.snp.trailing).inset(HomeScreenALConstants.postImageSideInset)
            make.height.equalTo(HomeScreenALConstants.postImageHeight)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(verticalLineView.snp.bottom).offset(HomeScreenALConstants.separatorTopInset)
            make.leading.trailing.equalTo(postBodyView)
            make.height.equalTo(HomeScreenALConstants.separatorHeight)
        }
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

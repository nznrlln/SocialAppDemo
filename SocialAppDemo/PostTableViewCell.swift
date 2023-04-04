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
        label.numberOfLines = 4
        label.text = "Обязательно вступите в группу курса в Телеграм группа PRO, вся оперативная информация там, но на первой неделе мы будем присылать рассылку о новых уроках"

        return label
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
        self.backgroundColor = Palette.darkButton

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(avatarImageView,
                         authorNicknameLabel,
                         authorStatusLabel,
                         postImageView,
                         postDescriptionLabel,
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

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(PostScreenALConstants.separatorTopInset)
            make.leading.trailing.equalToSuperview().inset(PostScreenALConstants.generalSideInset)
            make.height.equalTo(PostScreenALConstants.separatorHeight)
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

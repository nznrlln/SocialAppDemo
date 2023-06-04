//
//  MiniPhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 19.06.2022.
//

import UIKit
import SnapKit

class MiniPhotosCollectionViewCell: UICollectionViewCell {

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: UIImage) {
        photoImageView.image = model
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.image = nil
    }

    private func cellInitialSetting() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Palette.mainAccent?.cgColor
        self.clipsToBounds = true


        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.contentView.addSubview(photoImageView)
    }

    private func setupSubviewsLayout() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}


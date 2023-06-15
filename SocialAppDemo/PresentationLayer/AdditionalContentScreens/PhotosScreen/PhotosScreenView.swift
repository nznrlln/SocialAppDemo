//
//  PhotosScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.05.2023.
//

import UIKit

protocol PhotosScreenViewDelegate: AnyObject {
    var photos: [UIImage] { get }
}

class PhotosScreenView: UIView {

    weak var delegate: PhotosScreenViewDelegate?

    private lazy var collectionLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { (section, environmet) -> NSCollectionLayoutSection? in

            // количество элементов в строке/группе
            // размер контента = "пространство коллекции", обращаемся к контейнеру коллекции и берем значение его размера
            let numberOfItemsInRow: CGFloat = PhotosScreenALConstants.numberOfItemsInRow
            let contentSize = environmet.container.contentSize

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(PhotosScreenALConstants.itemFractionalWidth),
                heightDimension: .fractionalHeight(PhotosScreenALConstants.itemFractionalHeight)
            )
            // за конкретное вычисление ширины каждого обьекта - отвечает группа
            // высота элемента = высоте группы
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            // высота группы = 0.7 ширины элемента
            let groupHeight = 0.7 * (contentSize.width - numberOfItemsInRow * PhotosScreenALConstants.itemSpacing) / numberOfItemsInRow
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(PhotosScreenALConstants.groupFractionalWidth),
                heightDimension: .absolute(groupHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: Int(numberOfItemsInRow) // количество элементов в одной группе
            )
            group.interItemSpacing = .fixed(PhotosScreenALConstants.itemSpacing)
            // отступы группы от секции
            group.contentInsets = .init(
                top: 0,
                leading: PhotosScreenALConstants.groupInset,
                bottom: 0,
                trailing: PhotosScreenALConstants.groupInset
            )

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = PhotosScreenALConstants.groupSpacing
            section.supplementariesFollowContentInsets = true

            return section
        }

    }()

    lazy var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = Palette.mainBackground

        collectionView.dataSource = self
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
        )

        return collectionView
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
        self.addSubview(photosCollectionView)
    }

    private func setupSubviewsLayout() {
        photosCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
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


extension PhotosScreenView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath
        ) as! PhotosCollectionViewCell
        cell.setupCell(model: delegate?.photos[indexPath.item])

        return cell
    }

}

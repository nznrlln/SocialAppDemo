//
//  PhotosScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.05.2023.
//

import UIKit

class PhotosScreenViewController: UIViewController {

    private let model: PhotosScreenModel

    private lazy var mainView: PhotosScreenView = {
        let view = PhotosScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    init(model: PhotosScreenModel) {
        self.model = model

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    private func viewInitialSettings() {
        view.backgroundColor = Palette.mainBackground

        setupModels()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupModels() {
        model.delegate = self
        model.getModelData()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

// MARK: - PhotosScreenModelDelegate

extension PhotosScreenViewController: PhotosScreenModelDelegate {
    func modelUpdatedPhotos() {
        mainView.photosCollectionView.reloadData()
    }
}


// MARK: - PhotosScreenModelDelegate

extension PhotosScreenViewController: PhotosScreenViewDelegate {
    var photos: [UIImage] {
        model.userPhotos
    }
}

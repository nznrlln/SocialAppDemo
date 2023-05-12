//
//  SavedScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 09.04.2023.
//

import UIKit

class SavedScreenView: UIView {

    var savedPostsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.separatorStyle = .none

        return tableView
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
        self.addSubview(savedPostsTableView)
    }

    private func setupSubviewsLayout() {
        savedPostsTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

//
//  PostsTableView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 10.04.2023.
//

import UIKit

protocol PostsTableViewDataSource {}

class PostsTableView: UITableView {

    var tvDataSource: PostsTableViewDataSource?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        tableInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func tableInitialSettings() {
        self.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)

        self.dataSource = self
        self.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension PostsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell

        return cell
    }


}

// MARK: - UITableViewDelegate

extension PostsTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}

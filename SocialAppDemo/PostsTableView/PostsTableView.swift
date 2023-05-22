//
//  PostsTableView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 10.04.2023.
//

import UIKit

protocol PostsTableViewDelegate {
    func didSaveTap(post: PostModel, author: UserModel)
    func didSelectPost(post: PostModel, author: UserModel)
}

class PostsTableView: UITableView {

    var tvDelegate: PostsTableViewDelegate?

    var posts: [String?: [PostModel]]
    var postsDates: [String]
    var authors: [UserModel]

    init(frame: CGRect, style: UITableView.Style,
         posts: [String?: [PostModel]]?,
         postsDates: [String]?,
         authors: [UserModel]?) {

        self.posts = posts ?? [:]
        self.postsDates = postsDates ?? []
        self.authors = authors ?? []
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

        self.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource

extension PostsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return postsDates.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateKey = postsDates[section]
        guard let values = posts[dateKey] else {return 0}

        return values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell

        let dateKey = postsDates[indexPath.section]
        if let models = posts[dateKey] {
            let postData = models[indexPath.row]
            guard let author = authors.first(where: { $0.userUID == postData.authorUID}) else { return cell }
            cell.setupCellWith(model: postData, author: author)

            cell.saveButtonTapAction = { [weak self] in
                self?.tvDelegate?.didSaveTap(post: postData, author: author)
            }
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DateSectionHeaderView()
        headerView.setupHeader(model: postsDates[section])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        26
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = Palette.mainBackground
        
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dateKey = postsDates[indexPath.section]
        if let model = posts[dateKey] {
            let postData = model[indexPath.row]
            guard let author = authors.first(where: { $0.userUID == postData.authorUID}) else { return }
            tvDelegate?.didSelectPost(post: postData, author: author)
        }

    }
}

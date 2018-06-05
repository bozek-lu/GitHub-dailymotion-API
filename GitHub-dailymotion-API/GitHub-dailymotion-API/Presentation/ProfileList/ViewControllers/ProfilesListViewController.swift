//
//  ProfilesListViewController.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import UIKit

class ProfilesListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private properties

    private let showDetailSegueId = "showDetail"
    private let cellIdentifier = "cellIdentifier"
    private var profiles = [BaseUserModel]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        let nibName = UINib(nibName: "ProfilesListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
            let controller = navigationController.viewControllers.last {
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true

            if segue.identifier == showDetailSegueId,
                let owner = controller as? ProfileDetailsOwner,
                let indexPath = tableView.indexPathForSelectedRow {
                let document = profiles[indexPath.row]
                owner.setup(with: document)
            }
        }

    }
}

// MARK: - DocumentsListOwner

extension ProfilesListViewController: ProfilesListOwner {
    func setup(with profiles: [BaseUserModel]?) {
        self.profiles = profiles ?? [BaseUserModel]()
    }
}

// MARK: - UITableViewDataSource

extension ProfilesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        guard let documentCell = cell as? ProfilesListTableViewCell else {
            return cell
        }

        let profile = profiles[indexPath.row]
        let cellViewModel = ProfileCellViewModel(profile: profile)
        documentCell.fill(with: cellViewModel)

        return documentCell
    }
}

// MARK: - UITableViewDelegate

extension ProfilesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showDetailSegueId, sender: self)
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = tableView.separatorColor
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = view.backgroundColor
    }
}

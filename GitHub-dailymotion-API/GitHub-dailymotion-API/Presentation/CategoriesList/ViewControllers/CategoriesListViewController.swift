//
//  CategoriesListViewController.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import UIKit

class CategoriesListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    @IBOutlet private var noDataLabel: UILabel!

    // MARK: - Private properties

    private let showDocumentsSegueId = "showProfilesList"
    private lazy var viewModel = CategoriesListViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()

        indicatorView.startAnimating()
        loadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDocumentsSegueId,
            let owner = segue.destination as? ProfilesListOwner,
            let indexPath = tableView.indexPathForSelectedRow {
            owner.setup(with: viewModel.profiles(for: indexPath))
        }
    }

    // MARK: - Private methods

    @objc private func loadData() {
        noDataLabel.isHidden = true

        viewModel.loadData { [weak self] completion in
            self?.indicatorView.stopAnimating()
            self?.tableView.refreshControl?.endRefreshing()
            self?.noDataLabel.isHidden = self?.viewModel.categoriesCount != 0

            switch completion {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                self?.noDataLabel.isHidden = false
                self?.showAlert(for: error)
            }
        }
    }

    private func showAlert(for error: Error) {
        let message = "Connection problem.\nPlease, try again later."
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

        print(error)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = viewModel.category(for: indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showDocumentsSegueId, sender: self)
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = tableView.separatorColor
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = view.backgroundColor
    }
}

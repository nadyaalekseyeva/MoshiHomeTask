//
//  AlbumsListViewController.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

final class AlbumsListViewController: UIViewController {
    
    let presenter: AlbumsListPresenter
    
    init(presenter: AlbumsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Screen life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Albums"
        
        view.addSubview(tableView)
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateAlbums { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension AlbumsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.albums.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumCell.identifier,
            for: indexPath
        ) as? AlbumCell
        else { return UITableViewCell() }
        
        cell.update(with: presenter.albums[indexPath.row]) { [weak self] url in
            let ac = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            self?.present(ac, animated: true)
            // NA: should be done by flow
        }
        
        return cell
    }
    
}

// MARK: - UI elements setup
private extension AlbumsListViewController {
 
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        
        tableView.register(
            AlbumCell.self,
            forCellReuseIdentifier: AlbumCell.identifier
        )
    }
    
}



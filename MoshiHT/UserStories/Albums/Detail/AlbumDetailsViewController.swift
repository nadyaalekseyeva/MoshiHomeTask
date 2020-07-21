//
//  AlbumDetailsViewController.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import UIKit

final class AlbumDetailsViewController: UIViewController {
    
    let presenter: AlbumDetailsPresenter
    
    init(presenter: AlbumDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        title = presenter.album.name
        
        view.addSubview(coverImage)
        
        let stackView = UIStackView(arrangedSubviews: [artistLabel, releaseDateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        let offset: CGFloat = 16.0
        let constraints = [
            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coverImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImage.heightAnchor.constraint(equalTo: coverImage.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            stackView.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: offset),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: offset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - UI Elements
    
    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView(image: presenter.getImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let artists = presenter.album.artists.map { $0.name }.joined(separator: " and ")
        label.text = "Artists: \(artists)"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let date = presenter.album.releaseDate {
            label.text = formattedDateString(from: date)
        }

        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
}

// MARK: - Helpers
private extension AlbumDetailsViewController {
    
    func formattedDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
    
}

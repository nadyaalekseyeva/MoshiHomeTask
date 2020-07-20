//
//  AlbumCell.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

final class AlbumCell: UITableViewCell {
    static let identifier = String(describing: AlbumCell.self)
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Layout
        let offset: CGFloat = 16
        
        addSubview(coverImageView)
        addSubview(textsStackView)
        addSubview(shareButton)
        
        let constraints = [
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset / 2),
            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: offset / 2),
            bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: offset / 2),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),
            textsStackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: offset),
            textsStackView.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: textsStackView.trailingAnchor, constant: offset),
            shareButton.centerYAnchor.constraint(equalTo: textsStackView.centerYAnchor),
            trailingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: offset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: - Update
    
    func update(with album: Album) {
        coverImageView.image = album.image
        titleLabel.text = album.name

        if let date = album.releaseDate {
            subtitleLabel.text = formattedDateString(from: date)
        }
        
        // NA: add share action
    }
    
    // MARK: - UI elements
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return button
    }()
    
}

// MARK: - Helpers
private extension AlbumCell {
    
    func formattedDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
    
}

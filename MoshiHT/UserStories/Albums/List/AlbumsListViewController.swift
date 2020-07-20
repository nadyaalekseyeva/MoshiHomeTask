//
//  AlbumsListViewController.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

final class AlbumsListViewController: UIViewController {
    private let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test text"
        return label
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(testLabel)
        let constraints = [
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

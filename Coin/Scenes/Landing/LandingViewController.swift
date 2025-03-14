//
//  LandingViewController.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import UIKit
import CoinNetworking

final class LandingViewController: UIViewController {
    
    var action: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Background Image
        let backgroundImage = UIImageView(image: UIImage(named: "windIcon"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Welcome Text
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Coin"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "All your favorite crypto in one place."
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.numberOfLines = 2
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 5
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Button
        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        continueButton.backgroundColor = .systemBlue
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 15
        continueButton.backgroundColor = .accent
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        // Stack for layout
        let stackView = UIStackView(arrangedSubviews: [textStack, continueButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        checkInternetConnection()
    }
    
    @objc private func handleContinue() {
        action?()
    }
    
    private func checkInternetConnection() {
        CoinReachability.checkInternetConnection()
    }
}

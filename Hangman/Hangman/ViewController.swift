//
//  ViewController.swift
//  Hangman
//
//  Created by Macbook on 21/02/2022.
//

import UIKit

class ViewController: UIViewController {

    var scoreLabel: UILabel!
    var hintLabel: UILabel!
    var usedLettersLabel: UILabel!
    var labelContainer: UIView!
    var buttonContainer: UIView!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        
        title = "HangMan"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(showHint))
        
        hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.font = UIFont.systemFont(ofSize: 20)
        hintLabel.textAlignment = .center
        hintLabel.numberOfLines = 0
        view.addSubview(hintLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        scoreLabel.textAlignment = .center
        scoreLabel.shadowColor = .gray
        view.addSubview(scoreLabel)
        
        usedLettersLabel = UILabel()
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        usedLettersLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(usedLettersLabel)
        
        labelContainer = UIView()
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelContainer)
        
        buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.backgroundColor = .darkGray
        view.addSubview(buttonContainer)
        
        NSLayoutConstraint.activate([
            labelContainer.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            labelContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            labelContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            buttonContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30),
            buttonContainer.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            buttonContainer.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            buttonContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            usedLettersLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            usedLettersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            usedLettersLabel.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: -10),
            
            hintLabel.topAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: 10),
            hintLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            hintLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


}


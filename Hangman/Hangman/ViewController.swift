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
    let alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",""]
    var buttonArray = [UIButton]()
    var selectedWord: String = ""
    var lettersPressed = [String]()
    var winner = false
    var tries = 0 {
        didSet {
            scoreLabel.text = "Tries: \(tries) out of 7"
        }
    }
    
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
        
        startGame()
        
        var count = 0
        let rowFrame = Int(buttonContainer.frame.size.width) / 10
        let colFrame = Int(buttonContainer.frame.size.height) / 4
        for row in 1...3 {
            for col in 1...9 {
                let button = UIButton(type: .system)
                button.setTitleColor(.white, for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = true
                button.setTitle(alphabet[count], for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                button.frame = CGRect(x: rowFrame * col, y: colFrame * row, width: 20, height: 20)
                buttonArray.append(button)
                buttonContainer.addSubview(button)
                count += 1
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
     
        if tries == 7 {
            gameOver()
        } else if winner {
            return
        } else {
            guard let letterPressed = sender.titleLabel?.text else { return }
            var indexes = [Int]()
            for (index, letter) in selectedWord.enumerated() {
                if letterPressed.contains(letter) {
                    indexes.append(index + 1)
                }
            }
            if !indexes.isEmpty {
                showLabelWhenRight(letterPressed, indexes)
            } else {
                tries += 1
            }
            sender.isHidden = true
            lettersPressed.append(letterPressed)
            usedLettersLabel.text = "Used Letters: " + lettersPressed.joined(separator: " ")
        
            checkWinner()
        }
    }


}


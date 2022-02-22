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
    var labelArray = [UILabel]()
    let hangmanDataSource = HangmanDataSource()
    var randomIndex = 0
    var selectedWordArray = [String.Element]()
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
    
    func startGame () {
        hangmanDataSource.parseWords()
        randomIndex = Int.random(in: 0...hangmanDataSource.words.count)
        selectedWord = hangmanDataSource.words[randomIndex]
        hangmanDataSource.word = selectedWord
        hangmanDataSource.parseWordDefinition()
        selectedWordArray = Array(selectedWord)
        hintLabel.text = ""
        winner = false
        
        let width = 70
        let height = 30
        let viewFrame = Int(labelContainer.frame.size.width) / (selectedWord.count + 1)
        
        for i in 1...Int(selectedWord.count) {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = true
            label.text = "__"
            label.tag = i
            label.font = UIFont.systemFont(ofSize: 20)
            label.frame = CGRect(x: viewFrame * i, y: height, width: width, height: height)
            labelArray.append(label)
            labelContainer.addSubview(label)
        }
        scoreLabel.text = ""
        usedLettersLabel.text = "Used Letters: "
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if let letterChosen = (sender.titleLabel?.text) {
            if tries == 6 && !selectedWordArray.contains(String.Element(letterChosen)){
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
    
    func showLabelWhenRight (_ letterPressed: String, _ indexes: [Int]) {
        for label in labelArray {
            for index in indexes {
                if index == label.tag {
                    label.text = letterPressed
                }
            }
        }
    }
    
    func gameOver() {
        scoreLabel.text = "Game Over"
        
        for label in labelArray {
            if label.text == "__" {
                label.text = String(selectedWordArray[label.tag - 1])
                label.textColor = .red
            }
        }
        selectedWordArray = []
    }

    func checkWinner() {
        var count = 0
        for label in labelArray {
            if label.text == "__" {
                count += 1
            }
        }
        if count == 0 {
            scoreLabel.text = "Winner"
            winner = true
        }
    }
    
    @objc func newGame() {
        for button in buttonArray {
            button.isHidden = false
        }
        labelArray.forEach { label in
            label.removeFromSuperview()
        }
        tries = 0
        lettersPressed = []
        startGame()
    }
    
    @objc func showHint() {
        let alert = UIAlertController(title: "Hint", message: "Do you want a hint to be shown ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self, weak alert] alert in
            self.hintLabel.text = self.hangmanDataSource.definition
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        present(alert, animated: true)
    }

}


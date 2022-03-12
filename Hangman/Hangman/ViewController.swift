//
//  ViewController.swift
//  Hangman
//
//  Created by Macbook on 21/02/2022.
//

import UIKit

class GameViewController: UIViewController {

    var hangmanImage: UIImageView!
    var clueLabel: UILabel!
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
            hangmanImage.image = UIImage(named: "hangman\(tries)")
        }
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.jpg")!)
        
        title = "HangMan"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clue", style: .plain, target: self, action: #selector(showClue))
        navigationItem.leftBarButtonItem?.tintColor = .white

        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 20)
        clueLabel.textAlignment = .center
        clueLabel.numberOfLines = 0
        clueLabel.textColor = .white
        view.addSubview(clueLabel)
        
        hangmanImage = UIImageView()
        hangmanImage.contentMode = UIView.ContentMode.scaleAspectFill
        hangmanImage.translatesAutoresizingMaskIntoConstraints = false
        hangmanImage.image = UIImage(named: "hangman")
        view.addSubview(hangmanImage)
        
        usedLettersLabel = UILabel()
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        usedLettersLabel.font = UIFont.systemFont(ofSize: 15)
        usedLettersLabel.textColor = .white
        view.addSubview(usedLettersLabel)
        
        labelContainer = UIView()
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelContainer)
        
        buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
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
            
            hangmanImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hangmanImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            hangmanImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            hangmanImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            usedLettersLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            usedLettersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            usedLettersLabel.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: -10),
            
            clueLabel.topAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: 10),
            clueLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            clueLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
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
        clueLabel.text = ""
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
            label.textColor = .white
            label.frame = CGRect(x: viewFrame * i, y: height, width: width, height: height)
            labelArray.append(label)
            labelContainer.addSubview(label)
        }
        hangmanImage.image = UIImage(named: "hangman")
        usedLettersLabel.text = "Used Letters: "
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if let letterChosen = (sender.titleLabel?.text) {
            if tries == 9 && !selectedWordArray.contains(String.Element(letterChosen)){
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
        hangmanImage.image = UIImage(named: "hangman10")
        for label in labelArray {
            

            
                if label.text == "__" {
                    label.transform = CGAffineTransform(translationX: 0, y: -100)
                    label.text = String(self.selectedWordArray[label.tag - 1])
                    label.textColor = .red
                    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
                    label.transform = .identity
                }
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
            winner = true
            showWinAlert()
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
    
    @objc func showClue() {
        if clueLabel.text == "" {
            let alert = UIAlertController(title: "Clue", message: "Do you want a clue to be shown ? It will cost you one life", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self, weak alert] alert in
                self.clueLabel.text = self.hangmanDataSource.definition
                tries += 1
            }))
            alert.addAction(UIAlertAction(title: "No", style: .destructive))
            present(alert, animated: true)
        } else {
            let alert2 = UIAlertController(title: nil, message: "The clue is already on screen", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert2, animated: true)
        }
    }
    
    func showWinAlert() {
        let alert = UIAlertController(title: "You're alive !!!", message: "Want to play again ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.newGame()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        present(alert, animated: true)
    }

}


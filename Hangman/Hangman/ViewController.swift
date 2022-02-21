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
    }


}


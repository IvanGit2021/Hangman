//
//  ViewController.swift
//  Hangman
//
//  Created by Macbook on 21/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        
        title = "HangMan"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(showHint))
    }


}


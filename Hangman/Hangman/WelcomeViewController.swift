//
//  WelcomeViewController.swift
//  Hangman
//
//  Created by Macbook on 12/03/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var xTitleConstraint: NSLayoutConstraint!
    @IBOutlet var xButtonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        xTitleConstraint.constant -= view.bounds.width
        xButtonConstraint.constant -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        xTitleConstraint.constant = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
        
        xButtonConstraint.constant = 0
        
        UIView.animate(withDuration: 1, delay: 0.7, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

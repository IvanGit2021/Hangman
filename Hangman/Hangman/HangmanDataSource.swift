//
//  HangmanDataSource.swift
//  Hangman
//
//  Created by Macbook on 21/02/2022.
//

import Foundation

class HangmanDataSource {
    
    var word = ""
    var definition = ""
    var words = [String]()
    let url = "https://api.dictionaryapi.dev/api/v2/entries/en/"

    func parseWordDefinition() {
        if let url = URL(string: url + word) {
            if let data = try? Data(contentsOf: url) {
                parse(data)
                
            }
        }
    }
    
    func parse(_ json: Data) {
        if let wordDefinition = try? JSONDecoder().decode([WordModel].self, from: json) {
            definition = wordDefinition[0].meanings[0].definitions[0].definition
        }
    }

    func parseWords() {
        if let textWords = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let allWords = try? String(contentsOf: textWords) {
                words = allWords.components(separatedBy: "\n")
            }
        }
    }
}

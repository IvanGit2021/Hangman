//
//  Hangman Model.swift
//  Hangman
//
//  Created by Macbook on 21/02/2022.
//

import Foundation

struct WordModel: Codable {
    let meanings: [Definitions]
}

struct Definitions: Codable {
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition: String
}

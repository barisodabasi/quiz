//
//  QuestionData.swift
//  Trivial
//
//  Created by BarisOdabasi on 12.12.2020.
//

import Foundation

struct QuestionData: Codable {
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}

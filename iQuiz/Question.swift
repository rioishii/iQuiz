//
//  Question.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/20/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import Foundation

class Question {
    var question: String
    var answers: [String]
    var correctAnswer: String
    
    init (question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}

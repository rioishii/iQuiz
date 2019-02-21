//
//  Category.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/20/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import Foundation
import UIKit

class Category {
    var image: UIImage
    var subject: String
    var desc: String
    var questions: [Question]
    
    init(image: UIImage, subject: String, desc: String, questions: [Question]) {
        self.image = image
        self.subject = subject
        self.desc = desc
        self.questions = questions
    }
}



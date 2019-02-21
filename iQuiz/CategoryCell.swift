//
//  CategoryCell.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/20/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categorySubject: UILabel!
    @IBOutlet weak var categoryDesc: UILabel!
    
    var questions: [Question] = []
    
    func setCategory(category: Category) {
        categoryImageView.image = category.image
        categorySubject.text = category.subject
        categoryDesc.text = category.desc
        questions = category.questions
    }
}

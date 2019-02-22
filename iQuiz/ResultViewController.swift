//
//  ResultViewController.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/19/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var score : Int?
    var questions : [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalScore.text = "\(self.score!) / \(self.questions.count)"
        if (self.score == questions.count) {
            label.text = "Perfect!"
        } else {
            label.text = "Nice Try better luck next time!"
        }
    }
    
}

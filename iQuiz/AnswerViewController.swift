//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/19/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctWrongLabel: UILabel!
    
    var selectedCorrectAnswer : Bool?
    var questionIndex : Int?
    var score : Int?
    var questions : [Question] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = self.questions[questionIndex!].question
        correctAnswerLabel.text = self.questions[questionIndex!].correctAnswer
        scoreLabel.text = "\(String(self.score!))/\(self.questions.count)"
        correctWrongLabel.text = selectedCorrectAnswer! ?
            "Correct!" : "Wrong!"
    }
    
    
    @IBAction func nextScene(_ sender: UIButton) {
        if self.questionIndex! + 1 < (questions.count) {
            performSegue(withIdentifier: "nextQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "showResults", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "nextQuestion") {
            let destination = segue.destination as! UINavigationController
            let qvc = destination.topViewController as! QuestionViewController
            qvc.questions = self.questions
            qvc.questionIndex = self.questionIndex! + 1
            qvc.score = self.score!
        }
//        else {
//            let vc = segue.destination as! ResultViewController
//            rvc.questions = self.questions
//            rvc.currentScore = self.currentScore
//        }
    }

}

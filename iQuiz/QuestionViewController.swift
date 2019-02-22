//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/19/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var questions : [Question]?
    var questionIndex = 0
    var answerIndex = 0
    var selectedAnswer = ""
    var selectedCorrectAnswer = false
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        questionLabel.text = self.questions![questionIndex].question
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rvc = segue.destination as! AnswerViewController
        rvc.selectedCorrectAnswer = self.selectedCorrectAnswer
        rvc.questionIndex = self.questionIndex
        if (self.selectedCorrectAnswer) {
            self.score += 1
        }
        rvc.score = self.score
        rvc.questions = self.questions!
    }
    
}

extension QuestionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions![questionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = questions![questionIndex]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerCell
        if (answerIndex <= question.answers.count) {
            cell.answerLabel.text = question.answers[answerIndex]
            answerIndex += 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswer = self.questions![questionIndex].answers[indexPath.row]
        let correctAnswer = self.questions![questionIndex].correctAnswer
        self.selectedCorrectAnswer = (selectedAnswer == correctAnswer) ? true : false
    }
}



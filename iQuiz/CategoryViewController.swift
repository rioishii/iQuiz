//
//  CategoryViewController.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/9/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categories: [Category] = []
    var urlTextField: UITextField?
    var jsonUrlString = "https://tednewardsandbox.site44.com/questions.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadJsonData(jsonUrlString: jsonUrlString)
    }
    
    func loadJsonData(jsonUrlString: String) {
        categories.removeAll()
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, reponse, err) in
            guard let data = data else { return }
            
            if !CheckInternet.Connection() {
                self.loadOfflineData()
            }
        
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! Array<[String: Any]>
                self.parseJson(json)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    
                let string = String(data: data, encoding: String.Encoding.utf8)
                UserDefaults.standard.set(string, forKey: "data")
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    func parseJson(_ json: Array<[String: Any]>) {
        for category in json {
            let subject = category["title"] as! String
            let description = category["desc"] as! String
            var questions: [Question] = []
            for question in category["questions"]  as! [AnyObject] {
                let questionTitle = question["text"] as! String
                var answers: [String] = []
                let correctIndex = question["answer"] as! String
                for answer in question["answers"] as! [AnyObject] {
                    answers.append(answer as! String)
                }
                questions.append(Question(question: questionTitle, answers: answers, correctAnswer: answers[Int(correctIndex)!]))
                print(questions)
            }
            
            var image: UIImage
            if subject == "Mathematics" {
                image = UIImage(named: "math")!
            } else if subject == "Science!" {
                image = UIImage(named: "science")!
            } else if subject == "Marvel Super Heroes" {
                image = UIImage(named: "marvel")!
            } else {
                image = UIImage(named: "Blank")!
            }
            let category = Category(image: image, subject: subject, desc: description, questions: questions)
            self.categories.append(category)
        }
    }
    
    func loadOfflineData() {
        let string = UserDefaults.standard.object(forKey: "data") as! String!
        let jsonData = string?.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as! Array<[String: Any]>
        self.parseJson(json)
    }
    
    
    @IBAction func settingsAlert(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Retrieve JSON", message: "Enter an URL to fetch more categories!", preferredStyle: .alert)
        alert.addTextField(configurationHandler: urlTextField)
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: self.fetchHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {})
    }

    func urlTextField(textField: UITextField!) {
        urlTextField = textField
    }

    func fetchHandler(alert: UIAlertAction) {
        jsonUrlString = (urlTextField?.text)!.isEmpty ? "https://tednewardsandbox.site44.com/questions.json" : (urlTextField?.text)!
        loadJsonData(jsonUrlString: jsonUrlString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! CategoryCell
        let questions = cell.questions
        let destination = segue.destination as! UINavigationController
        let qvc = destination.topViewController as! QuestionViewController
        qvc.questions = questions
    }
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.setCategory(category: category)
        return cell
    }
}

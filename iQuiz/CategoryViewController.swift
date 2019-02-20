//
//  CategoryViewController.swift
//  iQuiz
//
//  Created by Rio Ishii on 2/9/19.
//  Copyright © 2019 Rio Ishii. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    var json_url = "https://tednewardsandbox.site44.com/questions.json"
    var urlTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonUrlString = "https://tednewardsandbox.site44.com/questions.json"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, reponse, err) in
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
        }.resume()
    }
    
//    @IBAction func settingsAlert(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController(title: "Retrieve JSON", message: nil, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
//    }
    
}

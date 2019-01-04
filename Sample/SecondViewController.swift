//
//  SEcondViewController.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 28/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var name = ""
    var questions: [Question]?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello " + name
        getTheQuestionList()
    }

    func getTheQuestionList() {
        guard let url = URL(string: "http://private-bf74b5-water2.apiary-mock.com/getAllQuestions") else { return }
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            if error != nil {
                self.showAPIError(from: error)
            } else {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Question].self, from: data!)
                    self.questions = result
                    self.tableView.reloadData()
                } catch let error {
                    self.showAPIError(from: error)
                }
            }
        }
        task.resume()
    }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        let question = questions?[indexPath.row] ?? Question()
        cell.textLabel?.text = question.questionText
        cell.detailTextLabel?.text = question.publishDate
        return cell
    }
}

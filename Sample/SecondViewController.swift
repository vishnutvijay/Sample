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
    var questions = [Question]()
    var questionDetails = [QuestionDetail]()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello " + name
//        getQuestionDetail()
        getQuestionsFromNewClient()
    }

    func getQuestionList() {
        guard let url = URL(string: "http://private-bf74b5-water2.apiary-mock.com/getAllQuestions") else { return }
        HTTPClient.shared.get(url, success: { [weak self] (result: [Question]) in
            self?.questions = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            self?.executeExamples(question: result.first!)
            
        }) { [weak self] error in
            self?.showAPIError(from: error)
        }
    }
    
    func getQuestionDetail() {
        guard let url = URL(string: "https://private-bf74b5-water2.apiary-mock.com/getQuestionDetails") else { return }
        HTTPClient.shared.get(url, success: { [weak self] (result: [QuestionDetail]) in
            self?.questionDetails = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }) { [weak self] error in
            self?.showAPIError(from: error)
        }
    }
    
    func getQuestionsFromNewClient() {
        guard let url = URL(string: "http://private-bf74b5-water2.apiary-mock.com/getAllQuestions") else { return }
        HTTPClient.shared.get(url, success: { [weak self] (result: [Question]) in
            self?.questions = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }) { [weak self] error in
            self?.showAPIError(from: error)
        }
    }
    func executeExamples(question: Question) {
        
        let question = self.questions.first!
        question.value(forKey: "questionText")
        print(question.getID())
    }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.questionText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY hh:mm a"
        cell.detailTextLabel?.text = dateFormatter.string(from: question.publishDate ?? Date())
        return cell
    }

}

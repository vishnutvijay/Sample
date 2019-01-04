//
//  Question.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 28/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import UIKit

class BaseQuestion {
    func baseFunction() {
        print("Executed function in base class")
    }
}

class Question: NSObject, Codable {


    @objc dynamic var id: Int
    @objc dynamic var questionText: String = ""
    @objc dynamic var publishDate: Date
    

    func baseFunction() {
        print("Executed fucnction in sub class")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case questionText = "question"
        case publishDate = "published_at"
    }
}

extension Question: Listable {
    var name: String {
        return questionText
    }
    
    func getID() {
        print("Final value of \(name)")
    }
}

extension Question: Showable {
    typealias T = String
    
    var name1: T {
        return ""
    }
}



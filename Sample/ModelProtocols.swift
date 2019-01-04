//
//  ModelProtocols.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 02/01/19.
//  Copyright © 2019 Adattiri, Ramya (Cognizant). All rights reserved.
//

import Foundation

protocol Listable {
    var name: String { get }
    func getID()
}

extension Listable {
    func getID() {
        print("Initial value of \(name)")
    }
}

protocol Showable {
    associatedtype T
    var name1: T { get }
}

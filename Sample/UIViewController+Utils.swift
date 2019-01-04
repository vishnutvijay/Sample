//
//  UIViewController+Utils.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 28/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import UIKit

extension UIViewController {
    func showAPIError(from error: Error?, completion: (() -> Void)? = nil) {
        guard let error = error else { return }
        let alertController = UIAlertController(title: "Failed", message: error.localizedDescription, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: completion)
        }
    }
}

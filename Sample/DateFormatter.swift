//
//  DateFormatter.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 31/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import Foundation

extension DateFormatter {
    
    var defaultDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY h:mm a"
        return dateFormatter
    }
    
    var APIDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }
}

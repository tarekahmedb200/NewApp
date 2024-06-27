//
//  String+Extension.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation


extension String {
    func toDate(withFormat format: DateFormats) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringValue
        return dateFormatter.date(from: self)
    }
}

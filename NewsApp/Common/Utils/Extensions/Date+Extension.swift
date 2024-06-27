//
//  Date+Extension.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation

extension Date {
    func toString(withFormat format: DateFormatter.Style) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        return dateFormatter.string(from: self)
    }
    
    static func getDifferenceBetweenDate(oldDate:Date,newDate:Date,with components: Set<Calendar.Component>) -> DateComponents {
        let diffComponents = Calendar.current.dateComponents(components, from: oldDate, to: newDate)
        let hours = diffComponents.hour
        let days = diffComponents.day
        return diffComponents
    }
    
    
    
    
}

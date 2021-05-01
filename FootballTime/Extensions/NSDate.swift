//
//  NSDate.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 28/04/2021.
//

import Foundation

extension NSDate: Comparable { }

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqual(to: rhs as Date)
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == .orderedAscending
}

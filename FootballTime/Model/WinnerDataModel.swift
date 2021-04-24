//
//  WinnerDataModel.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 24/04/2021.
//

import Foundation

struct WinnerDataModel: Decodable {
    
    // MARK: Properties
    
    let competition: Competition
    let matches: [Match]

}

// MARK: - Competition
struct Competition: Decodable {
    
    // MARK: Properties
    
    let name, code: String

}

// MARK: - Match
struct Match: Decodable {

    // MARK: Properties

    let utcDate: String

}

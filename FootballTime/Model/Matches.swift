//
//  Matches.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 24/04/2021.
//

import Foundation

struct Matches: Decodable {
    
    // MARK: Properties
    
    let competition: Competition
    let matches: [Match]

}

// MARK: - Competition
struct Competition: Decodable {
    
    // MARK: Properties
    
    let name: String
    let code: String

}

// MARK: - Match
struct Match: Decodable {

    // MARK: Properties

    let utcDate: String?
    let score: Score?
    let homeTeam: Area?
    let awayTeam: Area?

}

// MARK: - Area
struct Area: Decodable {
    let id: Int?
    let name: String?
}
//

// MARK: - Score
struct Score: Decodable {
    let winner: String?
}

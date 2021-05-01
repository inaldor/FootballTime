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
    
    let name, code: String

}

// MARK: - Match
struct Match: Decodable {

    // MARK: Properties

    let utcDate: String
    let score: Score
    let homeTeam, awayTeam: Area

}

// MARK: - Area
struct Area: Decodable {
    let id: Int
    let name: String
}
//
//// Mark: - Name
//struct Name: Decodable {
//    let name: String
//}

//enum Name: String, Codable {
//    case arminiaBielefeld = "Arminia Bielefeld"
//    case bayer04Leverkusen = "Bayer 04 Leverkusen"
//    case borussiaDortmund = "Borussia Dortmund"
//    case borussiaMönchengladbach = "Borussia Mönchengladbach"
//    case eintrachtFrankfurt = "Eintracht Frankfurt"
//    case fcAugsburg = "FC Augsburg"
//    case fcBayernMünchen = "FC Bayern München"
//    case fcSchalke04 = "FC Schalke 04"
//    case germany = "Germany"
//    case herthaBSC = "Hertha BSC"
//    case rbLeipzig = "RB Leipzig"
//    case scFreiburg = "SC Freiburg"
//    case svWerderBremen = "SV Werder Bremen"
//    case the1FCKöln = "1. FC Köln"
//    case the1FCUnionBerlin = "1. FC Union Berlin"
//    case the1FSVMainz05 = "1. FSV Mainz 05"
//    case tsg1899Hoffenheim = "TSG 1899 Hoffenheim"
//    case vfBStuttgart = "VfB Stuttgart"
//    case vfLWolfsburg = "VfL Wolfsburg"
//}

// MARK: - Score
struct Score: Decodable {
    let winner: String
}


//enum Winner: String, Codable {
//    case awayTeam = "AWAY_TEAM"
//    case draw = "DRAW"
//    case homeTeam = "HOME_TEAM"
//}


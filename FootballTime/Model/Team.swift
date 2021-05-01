//
//  Team.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 29/04/2021.
//

import Foundation

// MARK: - Welcome
struct Team: Codable {
    
    let id: Int
    let name, shortName, tla: String
    let address, phone: String
    let website: String
    let email: String
    let founded: Int
    let clubColors, venue: String

}

//
//  Team.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 29/04/2021.
//

import Foundation

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?

}

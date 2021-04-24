//
//  WinnerTeam.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import Foundation

// MARK: Model Support

struct WinnerTeamDataModel {
    
    let name: String
    let victories: Int
    let address: String
    
}

// MARK: Model Data

let team1 = WinnerTeamDataModel(name: "Vasco", victories: 50, address: "rua Vasco da gama 157 Rio fr jsnrito RJ")

let team2 = WinnerTeamDataModel(name: "flamengo", victories: 23, address: "Rua do flamengo 10")

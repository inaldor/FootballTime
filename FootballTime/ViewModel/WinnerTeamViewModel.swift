//
//  WinnerTeamViewModel.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import Foundation

//var winnerViewModel = WinnerTeamViewModel(name: "Vasco", victories: 50, address: "rua Vasco da gama 157 Rio fr jsnrito RJ")

var winnerTeamViewModel: [WinnerTeamViewModel] = [WinnerTeamViewModel(winnerTeamDataModel: team1), WinnerTeamViewModel(winnerTeamDataModel: team2)]

class WinnerTeamViewModel {
  
    private let winnerTeamDataModel: WinnerTeamDataModel
    
    init(winnerTeamDataModel: WinnerTeamDataModel) {
        
        self.winnerTeamDataModel = winnerTeamDataModel //WinnerTeamDataModel(name: "Vasco", victories: 50, address: "rua Vasco da gama 157 Rio fr jsnrito RJ")
        
    }
    
    
//    private var winnerDataModel = WinnerTeam(name: "Vasco", victories: 50, address: "rua Vasco da gama 157 Rio fr jsnrito RJ")
//
//    private let winnerDataModel: WinnerTeam
//
//    init(winnerDataModel: WinnerTeam) {
//
//        self.winnerDataModel = winnerDataModel
//
//    }
//
    var name: String {

        return winnerTeamDataModel.name

    }

    var address: String {

        return winnerTeamDataModel.address

    }

    var victories: String {

        return winnerTeamDataModel.victories.description

    }
    
}

//
//  WinnerTeamViewModel.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import Foundation

struct WinnerTeamViewModel {
    
    private let apiManager = APIManager()
  
    let matches: Matches
   
    private(set) var name = ""
    //private(set) var code = ""
    private(set) var winnerTeams: [Int] = []
    
    init(matches: Matches) {
        self.matches = matches
        let winTeams = getTeamsWonMost()
        winnerTeams = winTeams
        
        //getTeamInfo(teams: winnerTeams)
        updateProperties(winTeams: winTeams)
    }
    
//    var teamResult: Team? {
//        didSet {
//            guard let searchResult = teamResult else { return }
//            //winnerTeamViewModel = WinnerTeamViewModel.init(matches: searchResult)
//            DispatchQueue.main.async {
//                print(searchResult)
//            }
//
////            DispatchQueue.main.async {
////                print(teamResult!)
////            }
//
//
//        }
//    }
    

    private mutating func updateProperties(winTeams: [Int]) {
        name = setName(currentMatches: matches)
        //code = setCode(currentMatches: matches)
        winnerTeams = winTeams
    }
}

extension WinnerTeamViewModel {

    private func setName(currentMatches: Matches) -> String {
        return "Name: \(matches.competition.name)"
    }
//
//    private func setCode(currentMatches: Matches) -> String {
//        return "Code: \(matches.competition.code)"
//    }
    
    private func getTeamsWonMost() -> [Int] {
        
//        var datesArray: [Date] = []
//
        var wonMostThirtyDays: [Int] = []
        
        let datesMapped = matches.matches.map( { $0.utcDate })

        guard let datesArray = stringToDate(dateElementString: datesMapped) as? [Date] else { return [] }
        
//        for date in datesMapped {
//
//            guard let datesFormatted = DateFormatter.Default.response.date(from: date) else { return }
//
//            datesArray.append(datesFormatted)
//
//
//        }
        
        print(datesArray)
    
        if datesArray != [] {
            
            _ = datesArray.reduce(Date.distantPast) { $0 > $1 ? $0 : $1 }
            
            guard let lastCompetitionDate = datesArray.last else { return [] }
            
            let lastThirtyDays = getLastThirtyDays(lastCompDate: lastCompetitionDate)
            let matchesThirtyDays = matchesLastThirtyDays(keyDay: lastThirtyDays)
            let winnerThirtyDays = winnerLastThirtyDays(thirtyDaysMatchesArray: matchesThirtyDays)
            wonMostThirtyDays = findWonMostThirtyDays(winners: winnerThirtyDays)
            
        }
        
        return wonMostThirtyDays
        
    }
    
    private func getLastThirtyDays(lastCompDate: Date) -> Date{
        
        //let matchesLastThirtyDays = matches.matches
        
        let keyDay = lastCompDate.addingTimeInterval(86400 * -30)
        
        return keyDay
        
        //matchesLastThirtyDays(keyDay: keyDay)
        
        //print(keyDay)
    }
    
    private func matchesLastThirtyDays(keyDay: Date) -> [Match] {
        
        var thirtyDaysMatchesArray: [Match] = []
        
        
//        print(teste)
        
        //let ok = matches.matches.map( { $0.utcDate == KEYD })
        
        for match in matches.matches {

            guard let dateFormatted = stringToDate(dateElementString: match.utcDate) as? Date else { return [] }
            
            if dateFormatted.compare(keyDay) == .orderedDescending {
            
                print(match)
                print(match.utcDate)
                thirtyDaysMatchesArray.append(match)

            }
        }
        
        print(thirtyDaysMatchesArray)
        
        
        return thirtyDaysMatchesArray
    }
    
    private func winnerLastThirtyDays(thirtyDaysMatchesArray: [Match]) -> [Int] {
        
        var winners: [Int] = []
        
        for match in thirtyDaysMatchesArray {
            
            let matchWinner = match.score.winner
            
            print(matchWinner)
            
            if matchWinner == "HOME_TEAM" {
                
                winners.append(match.homeTeam.id)
                
            } else if matchWinner == "AWAY_TEAM" {
                
                winners.append(match.awayTeam.id)
                
            } else {
                
                print("Draw :)")
                
            }
        }
        
        print(winners)
        
        let ok = [19, 3, 11, 16, 5, 18, 10, 38, 19, 721, 4, 6, 15, 18, 17, 5, 28, 3, 4, 1, 19, 5, 38, 4, 11, 15, 2, 1, 15, 28, 3, 721, 18]
        
        return ok
        
    }
    
    private func findWonMostThirtyDays(winners: [Int]) -> [Int] {
        
        var counts: [Int: Int] = [:]
        var maxItem: Int = 0
        
        winners.forEach { counts[$0, default: 0] += 1 }
        
        for count in counts {
            
            if count.value > maxItem {
                
                maxItem = count.value
                
            }
        }
        
        let keys = counts
            .filter { (k, v) -> Bool in v == maxItem }
            .map { (k, v) -> Int in k }
        
        print(keys)
        
        return keys
        
    }
    
    
    private func stringToDate(dateElementString: Any) -> Any {
        
        var result: Any?
        
        if ((dateElementString.self as? [String]) != nil) {
            
            var datesArray: [Date] = []
            
            for date in dateElementString as! [String] {

                guard let datesFormatted = DateFormatter.Default.response.date(from: date) else { return [] }

                datesArray.append(datesFormatted)
                
            }
            
            result = datesArray
            
            
        } else if ((dateElementString.self as? String) != nil) {
            
            guard let dateFormatted = DateFormatter.Default.response.date(from: dateElementString as! String) else { return "" }

            result = dateFormatted
        }

        return result as Any
    }
 
}

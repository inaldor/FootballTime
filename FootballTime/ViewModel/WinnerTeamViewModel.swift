//
//  WinnerTeamViewModel.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import Foundation

struct WinnerTeamViewModel {
    
    // MARK: Properties
  
    let matches: Matches
   
    /// Variables to support the fetching and processing of match and team information
    private(set) var name = ""
    private(set) var winnerTeams: [Int] = []
    
    init(matches: Matches) {
        self.matches = matches
        
        let winTeams = getTeamsWonMost()
        winnerTeams = winTeams
        
        updateProperties(winTeams: winTeams)
    }
}

extension WinnerTeamViewModel {
    
    // MARK: Imperatives
    
    /// Function to update the name property of this struct
    private mutating func updateProperties(winTeams: [Int]) {
        name = setName(currentMatches: matches)
    }
    
    /// Function to update the name of the match
    private func setName(currentMatches: Matches) -> String {
        
        return matches.competition.name
    }
    
    /// Function to get the last competition date and return the team that won most in the last thirty days
    private func getTeamsWonMost() -> [Int] {

        var wonMostThirtyDays: [Int] = []
        
        let datesMapped = matches.matches.map( { $0.utcDate })

        guard let datesArray = stringToDate(dateElementString: datesMapped) as? [Date] else { return [] }
        
        if datesArray != [] {
            
            _ = datesArray.reduce(Date.distantPast) { $0 > $1 ? $0 : $1 }
            
            guard let lastCompetitionDate = datesArray.last else { return [] }
            
            
            /// Calling the next functions to process data
            let lastThirtyDays = getLastThirtyDays(lastCompDate: lastCompetitionDate)
            let matchesThirtyDays = matchesLastThirtyDays(keyDay: lastThirtyDays)
            let winnerThirtyDays = winnerLastThirtyDays(thirtyDaysMatchesArray: matchesThirtyDays)
            wonMostThirtyDays = findWonMostThirtyDays(winners: winnerThirtyDays)
            
        }
        
        return wonMostThirtyDays
        
    }
    
    /// Function to get the last thirty days from the last competition date
    private func getLastThirtyDays(lastCompDate: Date) -> Date{
        
        let keyDay = lastCompDate.addingTimeInterval(86400 * -30)
        
        return keyDay
        
    }
    
    /// Function to get the matches of the last thirty days
    private func matchesLastThirtyDays(keyDay: Date) -> [Match] {
        
        var thirtyDaysMatchesArray: [Match] = []
        
        for match in matches.matches {

            guard let dateFormatted = stringToDate(dateElementString: match.utcDate as Any) as? Date else { return [] }
            
            if dateFormatted.compare(keyDay) == .orderedDescending {
            
                thirtyDaysMatchesArray.append(match)

            }
        }
        
        return thirtyDaysMatchesArray
    }
    
    /// Function to get the Id of the teams that won in the last thirty days
    private func winnerLastThirtyDays(thirtyDaysMatchesArray: [Match]) -> [Int] {
        
        var winners: [Int] = []
        
        for match in thirtyDaysMatchesArray {
            
            let matchWinner = match.score.winner
            
            if matchWinner == "HOME_TEAM" {
                
                if let homeTeamWinner = match.homeTeam.id {
                
                    winners.append(homeTeamWinner)
                    
                }
                
            } else if matchWinner == "AWAY_TEAM" {
                
                if let awayTeamWinner = match.awayTeam.id {
                
                    winners.append(awayTeamWinner)
                    
                }
                
            } else {
                
                print("Draw :)")
                
            }
        }
        
        return winners
        
    }
    
    /// Function to calculate the team that won most in the last thirty days
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
        
        return keys
        
    }
    
    
    /// Function to convert a date in String type to a date in Date type
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

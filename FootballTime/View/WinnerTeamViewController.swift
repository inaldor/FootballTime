//
//  WinnerTeamViewController.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import UIKit

class WinnerTeamViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTeamLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tlaLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    //var teamsInfo: [Team?] = []
    
    private let apiManager = APIManager()
    
    private(set) var winnerTeamViewModel: WinnerTeamViewModel?
    
    var searchResult: Matches? {
        didSet {
            guard let searchResult = searchResult else { return }
            winnerTeamViewModel = WinnerTeamViewModel.init(matches: searchResult)
            DispatchQueue.main.async {
                self.updateLabels()
                //self.getTeamInfo(teams: self.winnerTeamViewModel?.winnerTeams ?? [])
                
                let teamsArray = self.winnerTeamViewModel?.winnerTeams ?? []
                
                //for team in teamsArray {
                    
                self.getTeamInfo(teams: teamsArray)
                        
                
                        
                        //updateTeamLabels()
                        
                        //teamsInfo.append(teams!)
                    
                        
                        
                        //})
                //}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMatches()
         
    }
}
    
extension WinnerTeamViewController {
    
    private func updateLabels() {
        guard let winnerTeamViewModel = winnerTeamViewModel else { return }
        nameLabel.text = winnerTeamViewModel.name
    }
    
    private func getMatches() {
        
        apiManager.getMatches() { (matches, error) in
            
            if let error = error {
                print("Get matches error: \(error.localizedDescription)")
                
                self.createAlert(errorType: error.localizedDescription)
                
                return
            }
            guard let matches = matches else { return }
            self.searchResult = matches
            //print("Current Matches Object:")
            //print(matches)
        }
    }
    
    
    private func getTeamInfo(teams: [Int]){
        
        var teamNames = ""
        
        apiManager.getTeams(teams: teams) { (teams, error) in
            
            print(teams)
            
            if let error = error {
                print("Get teams error: \(error.localizedDescription)")
                
                self.createAlert(errorType: error.localizedDescription)
                
                return
            }
            
//            if teams.isEmpty {
//
//                self.createAlert(errorType: "Error when Fetching requests")
//
//            }
            
            //guard let teams = teams else { return }
            //print(teams)
            
            //let nameTeams = teams.map( { $0?.name })
            
            for team in teams {

                if (team?.name == nil), (team?.id == nil) {
                    
                    self.createAlert(errorType: "Error when fetching requests")
                    
                } else {
                    
                    if let tm = team?.name {
                    
                        teamNames = teamNames + "\n " + tm
                        
                    }
                }
            }


            //print(teamNames)

            for team in teams {
                
                
            //nameTeamsArray.append(team?.name)

                if teams.count > 1 {
                    //"Name: \(competitionName)"
                    
                    self.nameTeamLabel.text = "Are\(teamNames)"
                    
                } else {
                    
                    if let teamName = team?.name {
                        
                        self.nameTeamLabel.text = "Is\n\(teamName)"
                        
                    }
                    
                    self.addressLabel.text = team?.address
                    self.tlaLabel.text = team?.tla
                    self.venueLabel.text = team?.venue
            //
                }
            }


        //completion(teams, nil)

        //teamsInfo.append(teams)

        }
    }
        
    
    func createAlert(errorType: String) {
        
//        let alert = UIAlertController(title: "Error", message: "\n\(errorType)\n\n Please, try again in one(1) minute.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(alert, animated: true, completion: dismiss(animated: true, completion: nil))
        
        let refreshAlert = UIAlertController(title: "Error", message: "\n\(errorType)\n\n Please, try again in one(1) minute.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)

        }))

        present(refreshAlert, animated: true, completion: nil)
    }
       
        //var teamsInfo: [Team] = []
        
        //for team in teams {
  
        //apiManager.getTeams(teams: teams)
        
        //print(ok)
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            let kidId =  self.apiManager.getTeams(teams: teams)
//            DispatchQueue.main.async {
//                print(kidId)
//            }
//        }
        
//            apiManager.getTeams(teams: teams) { (teams, error) in
//                if let error = error {
//                    print("Get teams error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let teams = teams else { return }
//                print(teams)
//
//                //completion(teams, nil)
//
//                //teamsInfo.append(teams)
//
//            }
        //return ok
        
        //}
    
    
        
//        print(teamsInfo)
        
        
//        self.addressLabel.text = teams.address
//        self.tlaLabel.text = teams.tla
//        self.venueLabel.text = teams.venue
//        self.websiteLabel.text = teams.website
        
        
 //   }
    
//    private func updateTeamLabels() {
//
//
//
//    }
}

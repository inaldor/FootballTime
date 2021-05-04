//
//  WinnerTeamViewController.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 23/04/2021.
//

import UIKit

/// Class to display the main information of the app
class WinnerTeamViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTeamLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tlaLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    private let apiManager = APIManager()
    
    private(set) var winnerTeamViewModel: WinnerTeamViewModel?
    
    /// A didset variable to be triggered after fetch of the matches of a single league
    var searchResult: Matches? {
        
        didSet {
            guard let searchResult = searchResult else { return }
            winnerTeamViewModel = WinnerTeamViewModel.init(matches: searchResult)
            
            DispatchQueue.main.async {
                
                self.updateLabels()
                let teamsArray = self.winnerTeamViewModel?.winnerTeams ?? []
                self.getTeamInfo(teams: teamsArray)
                
            }
            
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMatches()
         
    }
}
    
extension WinnerTeamViewController {
    
    // MARK: Imperatives
    
    /// Function responsible to update the label with the league's name
    private func updateLabels() {
        
        guard let winnerTeamViewModel = winnerTeamViewModel else { return }
        nameLabel.text = winnerTeamViewModel.name
    
    }
    
    /// Function responsible to request the matches of a single league
    private func getMatches() {
        
        apiManager.getMatches() { (matches, error) in
            
            if let error = error {
                print("Get matches error: \(error.localizedDescription)")
                
                self.createAlert(errorType: error.localizedDescription)
                
                return
            }
            
            guard let matches = matches else { return }
            self.searchResult = matches
            
        }
    }
    
    /// Function responsible to request and display the team information of the given team Ids
    private func getTeamInfo(teams: [Int]){
        
        var teamNames = ""
        
        apiManager.getTeams(teams: teams) { (teams, error) in
            
            print(teams)
            
            if let error = error {
                print("Get teams error: \(error.localizedDescription)")
                
                self.createAlert(errorType: error.localizedDescription)
                
                return
            }
            
            /// Check if any element of the array of teams was failed to be fetched(has nil value on all values)
            for team in teams {

                if (team?.name == nil), (team?.id == nil) {
                    
                    self.createAlert(errorType: "Error when fetching requests")
                    
                } else {
                    
                    if let tm = team?.name {
                    
                        teamNames = teamNames + "\n " + tm
                        
                    }
                }
            }

            /// Displaying team information on labels according to the quantity
            for team in teams {

                if teams.count > 1 {
                    
                    self.nameTeamLabel.text = "Are\(teamNames)"
                    
                } else {
                    
                    if let teamName = team?.name {
                        
                        self.nameTeamLabel.text = "Is\n\(teamName)"
                        
                    }
                    
                    self.addressLabel.text = team?.address
                    self.tlaLabel.text = team?.tla
                    self.venueLabel.text = team?.venue
            
                }
            }
        }
    }
        
    /// Function responsible to create and display an alert to give a feedback to the user when the request was not successful

    func createAlert(errorType: String) {
        
        let refreshAlert = UIAlertController(title: "Error", message: "\n\(errorType)\n\n Please, try again in one(1) minute.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)

        }))

        present(refreshAlert, animated: true, completion: nil)
    
    }
}

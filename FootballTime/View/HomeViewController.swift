//
//  HomeViewController.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 22/04/2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowWinner" {
            
            if let destinationViewController = segue.destination as? WinnerTeamViewController
            {
                destinationViewController.winnerTeamViewModel = winnerTeamViewModel[1]
            }
        }
        
    }
}

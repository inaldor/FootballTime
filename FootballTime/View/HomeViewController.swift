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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowWinner" {
            
            let destinationViewController = segue.destination as? WinnerTeamViewController

        }
        
    }
}

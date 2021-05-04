//
//  HomeViewController.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 22/04/2021.
//

import UIKit

/// The ViewController being responsible for display the first view of the app
class HomeViewController: UIViewController {

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Overrides
    
    /// Preparing to trigger a segue to the view that shows the main information of the app
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowWinner" {
            
            segue.destination as! WinnerTeamViewController

        }
        
    }
}

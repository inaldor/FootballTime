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
    @IBOutlet weak var victoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    //var winnerTeamViewModel: WinnerTeamViewModel = WinnerTeamViewModel()
    
    var winnerTeamViewModel: WinnerTeamViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(winnerTeamViewModel)
        
        nameLabel.text = winnerTeamViewModel?.name
        victoriesLabel.text = winnerTeamViewModel?.victories
        addressLabel.text = winnerTeamViewModel?.address
    }


}

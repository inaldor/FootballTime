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
        
        nameLabel.text = winnerTeamViewModel?.name
        victoriesLabel.text = winnerTeamViewModel?.victories
        addressLabel.text = winnerTeamViewModel?.address
        
        ok()
    }
    
    func ok() {
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: configuration)
        
        let url = URL(string: "https://api.football-data.org/v2/competitions/BL1/matches?status=FINISHED")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("e38530d104d94239bddf2c86e38837bf", forHTTPHeaderField: "X-Auth-Token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Oops!! there is server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("response is not json")
                return
            }
            
            do {
                
                guard let dataValue = data else { return }
                
                let items = try JSONDecoder().decode(WinnerDataModel.self, from: dataValue)
                    
                DispatchQueue.main.async {
                        print(items)
                }
//
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print("The Response is : ",json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        task.resume()
        
    }
}

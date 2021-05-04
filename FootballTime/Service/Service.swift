//
//  Service.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 24/04/2021.
//

import Foundation

/// The service being responsible for fetching data from the API
class APIManager {
    
    // MARK: Properties
    
    let baseURL = "https://api.football-data.org/v2/"
    
    let apiToken = "e38530d104d94239bddf2c86e38837bf"
    
    // MARK: Imperatives

    /// Function to prepare the fetch of the finished matches from the API for Bundesliga League
    func getMatches(completion: @escaping (_ matches: Matches?, _ error: Error?) -> Void) {
        
        let fullUrl = baseURL + "competitions/BL1/matches?status=FINISHED"
        
        getJSONFromURL(urlString: fullUrl) { (data, error) in
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            self.createMatchObjectWith(json: data, completion: { (matches, error) in
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error)
                }
                return completion(matches, nil)
            })
        }
    }
    
    /// Function to prepare the fetch of the teams from the API for Bundesliga League
    func getTeams(teams: [Int], completion: @escaping (_ teams: [Team?], _ error: Error?) -> Void) {
        
        var teamsInfo: [Team?] = []
        
        let myGroup = DispatchGroup()

        for team in teams {
            
            myGroup.enter()

            let fullUrl = baseURL + "teams/" + String(team)

            getJSONFromURL(urlString: fullUrl) { (data, error) in
                guard let data = data, error == nil else {
                    print("Failed to get data")
                    return
                }
                self.createTeamsObjectWith(json: data, completion: { (teams, error) in
                    if error != nil {
                        print("Failed to convert data")
                        
                        myGroup.leave()
                        
                        return
                    }

                    if let team = teams {
                        
                        print(team)
                        teamsInfo.append(team)
                        myGroup.leave()


                    }
                })
            }
        }

        myGroup.notify(queue: .main) {
            print("Finished all requests.")
            return completion(teamsInfo, nil)
        }
    }
    
}

extension APIManager {
    
    /// Function to run the URL Session and send back the JSON/Error back to another function
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
                
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(apiToken, forHTTPHeaderField: "X-Auth-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("*/*", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                
                print("Data is nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }

    /// Function to decode the JSON of Matches
    private func createMatchObjectWith(json: Data, completion: @escaping (_ data: Matches?, _ error: Error?) -> Void) {
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let matches = try decoder.decode(Matches.self, from: json)
            
            return completion(matches, nil)
            
        } catch let error {
            
            print("Error creating current matches from JSON because: \(error.localizedDescription)")
            
            return completion(nil, error)
        }
    }
    
    /// Function to decode the JSON of Teams
    private func createTeamsObjectWith(json: Data, completion: @escaping (_ data: Team?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let teams = try decoder.decode(Team.self, from: json)
            
            DispatchQueue.main.async {
                return completion(teams, nil)
            }
            
        } catch let error {
            print("Error creating current teams from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
    
}

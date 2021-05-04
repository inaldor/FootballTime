//
//  Service.swift
//  FootballTime
//
//  Created by Inaldo Ramos Ribeiro on 24/04/2021.
//

import Foundation

class APIManager {
    
    let baseURL = "https://api.football-data.org/v2/"
    
    let apiToken = "e38530d104d94239bddf2c86e38837bf"

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

//    func getTeams(teams: [Int], completion: @escaping (_ teams: Team?, _ error: Error?) -> Void) {
//
//        //let fullUrl = baseURL + "teams/" + String(team)
//
//        getJSONFromURL(teams: teams) { (data, error) in
//            guard let data = data, error == nil else {
//                print("Failed to get data")
//                return completion(nil, error)
//            }
//
//
//
//
//            self.createTeamsObjectWith(json: data, completion: { (teams, error) in
//                if let error = error {
//                    print("Failed to convert data")
//                    return completion(nil, error)
//                }
//                return completion(teams, nil)
//            })
//        }
//    }
    
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
                    if let error = error {
                        print("Failed to convert data")
                        
                        myGroup.leave()
                        
                        return
                    }

                    if let team = teams {
                        
                        print(team)

                        teamsInfo.append(team)

                        //teamInfo = team

                       // group.leave()
                        myGroup.leave()


                    }

                    //print(teamInfo)


                    //print(teamsInfo)

                   // group.wait()

                    //return completion(teams, nil)
                })
            }

            //guard teamsInfo.isEmpty else { break }

        }

        myGroup.notify(queue: .main) {
            print("Finished all requests.")
            print(teamsInfo)
            return completion(teamsInfo, nil)
           // return teamsInfo
        }

        //print(teamInfo)

        //return teamInfo!
            
            
            //Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"]).responseJSON { response in
                //print("Finished request \(i)")
//                myGroup.leave()
            //}
        //}
//
//        myGroup.notify(queue: .main) {
//            print("Finished all requests.")
//        }

            //let group = DispatchGroup() // initialize
            
            //var teamsInfo: [Team?] = []

//            var teamInfo: Team?
//
//
//
//
//            for team in teams {
//
//            //group.enter() // wait
//
//                let fullUrl = baseURL + "teams/4" /*+ String(team)*/
//
//                getJSONFromURL(urlString: fullUrl) { (data, error) in
//                    guard let data = data, error == nil else {
//                        print("Failed to get data")
//                        return
//                    }
//                    self.createTeamsObjectWith(json: data, completion: { (teams, error) in
//                        if let error = error {
//                            print("Failed to convert data")
//                            return
//                        }
//
//
//                        let returnedValue = self.synchronized(self) {
//                             // Your code here
//                             return teams
//                        }
//
//                        if let team = teams {
//
//                            //teamsInfo.append(team)
//
//                            teamInfo = team
//
//                           // group.leave()
//
//                        }
//
//                        print(teamInfo)
//
//
//                        //print(teamsInfo)
//
//                       // group.wait()
//
//                        //return completion(teams, nil)
//                    })
//                }
//
//                //guard teamsInfo.isEmpty else { break }
//
//            }
//
//            //print(teamInfo)
//
//            //return teamInfo!

    }
    
}

extension APIManager {
    
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
    
//    private func getJSONFromArrayURL(teams: [Int], completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
//
//        for teamId in teams {
//
//            let fullUrl = baseURL + "teams/" + String(teamId)
//
//            guard let url = URL(string: fullUrl) else {
//                print("Error: Cannot create URL from string")
//                return
//            }
//
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "GET"
//            urlRequest.setValue(apiToken, forHTTPHeaderField: "X-Auth-Token")
//            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            urlRequest.addValue("*/*", forHTTPHeaderField: "Accept")
//
//            let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
//                guard error == nil else {
//                    print("Error calling api")
//                    return completion(nil, error)
//                }
//                guard let responseData = data else {
//                    prinfct("Data is nil")
//                    return completion(nil, error)
//                }
//                completion(responseData, nil)
//            }
//            task.resume()
//
//        }
//    }

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

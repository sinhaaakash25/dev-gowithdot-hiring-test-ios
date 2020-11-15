//
//  ApiManager.swift
//  DOT_TASK
//
//  Created by Aakash Sinha on 12/11/20.
//  Copyright © 2020 Aakash Sinha. All rights reserved.
//

import Foundation


protocol ApiManagerDelegate {
    func didUpdateList(_ apiManager: ApiManager, pastList: [AppointmentsHistory])
    func didFailWithError(error: Error)
}

class ApiManager {
    
    let listURL = "http://104.215.179.29/v1/appointments?userId=105&userType=patients"
    
    var delegate: ApiManagerDelegate?
    
    func fetchMatch() {
        let urlString = listURL
        performRequest(with: urlString)
        
    }
    
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let pastList = self.parseJSON(safeData) {
                        self.delegate?.didUpdateList(self, pastList: pastList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ pastData: Data) -> [AppointmentsHistory]? {
        //print(pastData)
        
        var appointmentArray = [AppointmentsHistory]()
        
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AppointmentsHistory.self, from: pastData)
            
           // print(decodedData)
            
            appointmentArray = [decodedData]
            
            return appointmentArray
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
}

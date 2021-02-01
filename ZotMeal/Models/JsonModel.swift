import Foundation

protocol JSONProtocol {
    
    func categoryRetrieved(_ category:[Category])
    
    func error()
    
}

class JsonModel {
    
    var delegate:JSONProtocol?
    
    func loadLocalJSON(filename fileName: String) -> [Category]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                
                // print("jsonData is \(jsonData)")
                
                return jsonData.categories
            } catch {
                print("error: \(error)")
            }
        }
        print("loadJson returns nil, something is wrong")
        return nil
    }
    
    func loadRemoteJSONBrandy() {
        
        // Get a URL object
        let urlString = Constants.brandyURL
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create the URL object")
            return
        }
        
        // Get a URL session object
        let session = URLSession.shared
        
        // Get a data task object
        let dataTask = session.dataTask(with: url!) { (data:Data?, responese:URLResponse?, error:Error?) in
            
            if data == nil {
                DispatchQueue.main.async {
                    // Notify the delegate of the error
                    self.delegate?.error()
                }
            }
            
            // Check that there wasn't an error
            if error == nil && data != nil {
                
                do {
                    
                    // Create a JSON decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let response = try decoder.decode(ResponseData.self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI work
                    DispatchQueue.main.async {
                        
                        // Notify the delegate of the parsed objects
                        self.delegate?.categoryRetrieved(response.categories)
                        
                    }
                    
                    
                } catch  {
                    
                    DispatchQueue.main.async {
                        // Notify the delegate of the error
                        self.delegate?.error()
                    }
                    
                    print("Couldn't parse JSON")
                }
                
            }
            
        }
        
        // Call resume on the data task
        dataTask.resume()
        
    }
    
    func loadRemoteJSONAnt() {
        
        // Get a URL object
        let urlString = Constants.anteateryURL
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create the URL object")
            return
        }
        
        // Get a URL session object
        let session = URLSession.shared
        
        // Get a data task object
        let dataTask = session.dataTask(with: url!) { (data:Data?, responese:URLResponse?, error:Error?) in
            
            if data == nil {
                DispatchQueue.main.async {
                    // Notify the delegate of the error
                    self.delegate?.error()
                }
            }
            
            // Check that there wasn't an error
            if error == nil && data != nil {
                
                do {
                    
                    // Create a JSON decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let response = try decoder.decode(ResponseData.self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI work
                    DispatchQueue.main.async {
                        
                        // Notify the delegate of the parsed objects
                        self.delegate?.categoryRetrieved(response.categories)
                        
                    }
                    
                    
                } catch  {
                    DispatchQueue.main.async {
                        // Notify the delegate of the error
                        self.delegate?.error()
                    }
                    
                    print("Couldn't parse JSON")
                }
                
            }
            
        }
        
        // Call resume on the data task
        dataTask.resume()
        
    }
}

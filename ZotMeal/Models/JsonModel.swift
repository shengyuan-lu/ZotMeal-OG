import Foundation

class JsonModel {
    
    func parseLocalJSON(fileName: String) {
        
        if let localData = self.readLocalFile(fileName: fileName) {
            self.parse(jsonData: localData)
        }
        
    }
    
    func parseRemoteJSON(URL: String) {
        
        let urlString = URL
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func readLocalFile(fileName: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "JSON"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func loadJson(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Category.self, from: jsonData)
            
            print("Category: ", decodedData.category!)
            print("Food: ", decodedData.menu!)
            print("===================================")
        } catch {
            print("decode error")
        }
    }
    
}

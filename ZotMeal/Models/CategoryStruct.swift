import Foundation

struct Category {
    var categoryName:String
    var menu: [Food]
}


extension Category: Codable {
    
    enum Keys: String, CodingKey {
        case categoryName = "category"
        case menu = "menu"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.categoryName = try container.decode(String.self, forKey: .categoryName)
        
        self.menu = try container.decode([Food].self, forKey: .menu)
    }
}


import Foundation

struct Category {
    var category:String
    var menu: [Food]
}


extension Category: Codable {
    
    enum Keys: String, CodingKey {
        case category = "category"
        case menu = "menu"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.category = try container.decode(String.self, forKey: .category)
        
        self.menu = try container.decode([Food].self, forKey: .menu)
    }
}


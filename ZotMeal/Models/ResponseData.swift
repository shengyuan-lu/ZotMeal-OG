import Foundation

struct ResponseData {
    var categories: [Category]
}

extension ResponseData: Decodable {
    enum Keys: String, CodingKey {
        case categories = "restaurant"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.categories = try container.decode([Category].self, forKey: .categories)
    }
}

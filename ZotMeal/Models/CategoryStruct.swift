import Foundation

struct Category: Codable {
    var category:String = ""
    var menu: [Food] = []
    
    enum CodingKeys: String, CodingKey {
        case brandywine = "brandywine"
        case category = "category"
        case menu = "menu"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let categoryContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .brandywine)
        
        // Parse the category
        self.category = try categoryContainer.decode(String.self, forKey: .category)
        
        // Parse the menu
        self.menu = try categoryContainer.decode([Food].self, forKey: .menu)
    }
}

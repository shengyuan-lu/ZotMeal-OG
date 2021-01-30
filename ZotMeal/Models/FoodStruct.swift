import Foundation
import UIKit

struct Food {
    
    var name:String
    var calories:Int
    var description:String
    var isEatWell: Bool
    var isVegan: Bool
    var isPlantForward: Bool
    var isVegetarian: Bool
    var isWholeGrains: Bool

}

extension Food: Codable {
    enum Keys: String, CodingKey {
        case name = "name"
        case calories = "calories"
        case description = "description"
        case isEatWell = "isEatWell"
        case isVegan = "isVegan"
        case isPlantForward = "isPlantForward"
        case isVegetarian = "isVegetarian"
        case isWholeGrains = "isWholeGrains"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        self.calories = try container.decode(Int.self, forKey: .calories)
        
        self.description = try container.decode(String.self, forKey: .description)
        
        self.isEatWell = try container.decode(Bool.self, forKey: .isEatWell)
        
        self.isVegan = try container.decode(Bool.self, forKey: .isVegan)
        
        self.isPlantForward = try container.decode(Bool.self, forKey: .isPlantForward)
        
        self.isVegetarian = try container.decode(Bool.self, forKey: .isVegetarian)
        
        self.isWholeGrains = try container.decode(Bool.self, forKey: .isWholeGrains)
    }
}



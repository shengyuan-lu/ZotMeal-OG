import Foundation
import UIKit

struct Food: Codable {
    
    var name:String?
    var calories:Int?
    var description:Int?
    var isEatWell: Bool?
    var isVegan: Bool?
    var isPlantForward: Bool?
    var isVegetarian: Bool?
    var isWholeGrains: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case calories = "calories"
        case isEatWell = "isEatWell"
        case isVegan = "isVegan"
        case isPlantForward = "isPlantForward"
        case isVegetarian = "isVegetarian"
        case isWholeGrains = "isWholeGrains"
    }
    
    init (from decoder: Decoder) throws {
        
    }

}


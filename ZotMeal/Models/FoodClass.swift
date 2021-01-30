import Foundation
import UIKit

class Food {
    
    var name:String?
    var calories:Int?
    var description:Int?
    var isEatWell: Bool?
    var isVegan: Bool?
    var isPlantForward: Bool?
    var isVegetarian: Bool?
    var isWholeGrains: Bool?
    
    init(dict: [String: Any]) {
        name = dict["name"] as? String
        calories = dict["calories"] as? Int
        description = dict["description"] as? Int
        isEatWell = dict["isEatWell"] as? Bool
        isVegan = dict["isVegan"] as? Bool
        isPlantForward = dict["isPlantForward"] as? Bool
        isVegetarian = dict["isVegetarian"] as? Bool
        isWholeGrains = dict["isWholeGrains"] as? Bool
    }
    
}


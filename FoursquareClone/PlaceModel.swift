

import UIKit
import Foundation

class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeDescription = ""
    var placeImage = UIImage()
    var latitude = ""
    var longitude = ""
    
    
    private init (){}

    
}

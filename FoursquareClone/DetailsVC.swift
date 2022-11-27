//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPlaceName: UILabel!
    
    @IBOutlet weak var detailPlaceDescription: UILabel!
    @IBOutlet weak var detailPlaceType: UILabel!
    
    
    @IBOutlet weak var detailMapKit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add Too", style: UIBarButtonItem.Style.done, target: self, action: #selector(addToo))
    }
    
    @objc func addToo(){
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    



}

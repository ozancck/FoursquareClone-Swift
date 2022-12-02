//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPlaceName: UILabel!
    
    @IBOutlet weak var detailPlaceDescription: UILabel!
    
    @IBOutlet weak var detailPlaceType: UILabel!
    
    
    @IBOutlet weak var detailMapKit: MKMapView!
    
    var choosenPlaceID = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        getDataFromParse()
        detailMapKit.delegate = self
        
    }
    
    func getDataFromParse(){
        
        //OBJECTS
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceID)
        query.findObjectsInBackground{(objects, error) in
            if error != nil {
                
            }else {
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenPlaceObject = objects![0]
                        
                        if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                            self.detailPlaceName.text = placeName
                            
                        }
                        
                        if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                            self.detailPlaceType.text = placeType
                        }
                        
                        if let placeDescription = choosenPlaceObject.object(forKey: "description") as? String {
                            self.detailPlaceDescription.text = placeDescription
                        }
                        
                        if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                            if let choosenPlaceLatitude = Double(placeLatitude){
                                self.choosenLatitude = choosenPlaceLatitude
                            }
                        }
                        
                        if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as? String {
                            if let choosenPlaceLongitude = Double(placeLongitude) {
                                self.choosenLongitude = choosenPlaceLongitude
                            }
                        }
                        
                        if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground{(data, error) in
                                
                                if error == nil {
                                    if data != nil {
                                        self.detailImageView.image = UIImage(data: data!)
                                    }
                                }
                                
                            }
                        }
                        
                        //MAPS
                        
                        let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        
                        let region = MKCoordinateRegion(center: location, span: span)
                        
                        self.detailMapKit.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        
                        annotation.coordinate = location
                        annotation.title = self.detailPlaceName.text
                        annotation.subtitle = self.detailPlaceType.text
                        self.detailMapKit.addAnnotation(annotation)
                        
                        
                        
                        
                        
                        
                    }
                }
            }
        }
        
    }
    
    @objc func addToo(){
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var pinView = detailMapKit.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        }else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLatitude != 0.0 && self.choosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
             
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailPlaceName.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                    
                }
            }
            
        }
    }

}

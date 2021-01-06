//
//  MapView.swift
//  PCBuildApp
//
//  This class contains the definitions and functions for controlling
//  the map view and fetching the user's location for displaying map
//  information.
//
//  Created by GusMando on 11/1/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import UIKit
import MapKit
import UIKit
import CoreLocation

class MapView: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
{
    //Variables for holding map and user location info
    @IBOutlet weak var map: MKMapView!
    var manager:CLLocationManager!
    var locat:CLLocation!
    var searched:Bool!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Asssigning variables for handling and
        //initial conditions
        map.delegate = self
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        searched = false
    }
    
    //This function utilized to ensure that user has
    //Location Services enabled
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    //This function utilized for searching the map
    //for Computer Part bassed locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        //Fetching the newest location which pertains
        //to the user
        locat = locations[0]
        setLoc(loc:locat)
        
        if(!searched)
        {
            searchMap(str: "Computer Parts")
            searched = true
        }
    }

    //This function opens the url of any annotation selected on the
    //map to a webview
    func mapView(_ mapView: MKMapView,didSelect view: MKAnnotationView)
    {
        //Fetching link and URL
        let link = view.annotation!.subtitle
        let url = URL(string: link!!)
        
        //Opening the url
        UIApplication.shared.openURL(url!)
    }
    
    //This function is used to set the location of the user and to crete a
    //pin using this location
    func setLoc(loc:CLLocation)
    {
        let region = MKCoordinateRegion(center: loc.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.20, longitudeDelta: 0.20) )
        let ani = MKPointAnnotation()
        ani.title = "Your Location"
        ani.coordinate = loc.coordinate
        map.region = region
        map.addAnnotation(ani)
    }
    
    //This function will be used to create the actual search request
    //for the map based on a pased in string
    func searchMap(str: String)
    {
       //Creating the search request
       let request = MKLocalSearch.Request()
       request.naturalLanguageQuery = str
       request.region = map.region
        
       //Searching the request
       let search = MKLocalSearch(request: request)
       search.start {response,_ in guard let response = response
           else
       {
           return
       }
       print( response.mapItems )
        
       //Saving results and displaying pins
       var matchingItems:[MKMapItem] = []
       matchingItems = response.mapItems
       self.displayPins(list: matchingItems)
       }
        
    }
    
    //This function utilized for displaying pins to the user
    func displayPins(list: [MKMapItem])
    {
        //For each location in the passed in list
        for i in 1...list.count - 1
        {
            //Create a pin annotation with business information
            let what = MKPointAnnotation()
            what.title = list[i].name
            what.subtitle = list[i].url?.absoluteString
            what.coordinate = list[i].placemark.coordinate
            self.map.addAnnotation(what)
        }
    }
    
    //This function handles errors from location manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

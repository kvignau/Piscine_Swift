//
//  SecondViewController.swift
//  d05
//
//  Created by Kevin VIGNAU on 10/8/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var viewChoice: UISegmentedControl!
    @IBAction func viewChoice(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = MKMapType.standard
        }
        else if sender.selectedSegmentIndex == 1 {
            mapView.mapType = MKMapType.satellite
        }
        else if sender.selectedSegmentIndex == 2 {
            mapView.mapType = MKMapType.hybrid
        }
    }
    
    var places: [Place] = [] {
        didSet {
            places.forEach { (place) in
                mapView.addAnnotation(place.annotation)
            }
        }
    }
    
    var locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func findMe(_ sender: UIButton) {
        if let locations = locationManager.location{
            let center = CLLocationCoordinate2D(latitude: locations.coordinate.latitude, longitude: locations.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ((tabBarController as! TabBarViewController).myBool == true) {
            goToIndex(index: (tabBarController as! TabBarViewController).index)
            (tabBarController as! TabBarViewController).myBool = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChoice.backgroundColor = .white
        places = (tabBarController as! TabBarViewController).places
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        goToIndex(index: 0)
    }
    
    func goToIndex(index: Int)
    {
        if (index < places.count) {
            self.mapView.setRegion(places[index].region, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SecondViewController
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.pinTintColor = UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: 1)
        annotationView.canShowCallout = true
        return annotationView
    }
}


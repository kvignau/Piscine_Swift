//
//  ViewController.swift
//  rush01
//
//  Created by Vivien KLAOUSEN on 10/12/18.
//  Copyright © 2018 Vivien KLAOUSEN. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ViewController : UIViewController {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var myRoute:MKRoute?
    var transportType: MKDirectionsTransportType = .automobile
    var myPosition: CLLocationCoordinate2D?
    var myAnnotation: MKPointAnnotation = MKPointAnnotation()

    @IBOutlet weak var kmLablel: UILabel!
    
    @IBOutlet weak var styleTransporType: UISegmentedControl!
    
    @IBAction func selectTransportType(_ sender: UISegmentedControl) {
        if let route = myRoute {
            self.mapView.remove((route.polyline))
            kmLablel.text = ""
        }
        if sender.selectedSegmentIndex == 0 {
            transportType = .automobile
        }
        else if sender.selectedSegmentIndex == 1 {
            transportType = .walking
        }
        else if sender.selectedSegmentIndex == 2 {
            transportType = .transit
        }
        getDirections()
    }
    
    @IBAction func localizeMe(_ sender: UIButton) {
        if let route = myRoute {
            self.mapView.remove((route.polyline))
            kmLablel.text = ""
        }
        mapView.removeAnnotation(myAnnotation)
        if let locations = locationManager.location{
            myPosition = locations.coordinate
            let center = CLLocationCoordinate2D(latitude: (myPosition?.latitude)!, longitude: (myPosition?.longitude)!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func                setupSeg()
    {
        styleTransporType.backgroundColor = .white
        styleTransporType.layer.masksToBounds = true
        styleTransporType.layer.cornerRadius = styleTransporType.frame.height / 2
        styleTransporType.layer.borderWidth = 1
        styleTransporType.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1.0, alpha: 1).cgColor
        
        styleTransporType.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        styleTransporType.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .selected)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeg()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(_ sender: UILongPressGestureRecognizer) {
        if let route = myRoute {
            self.mapView.remove((route.polyline))
            kmLablel.text = ""
        }
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        myPosition = locationCoordinate
        myAnnotation.coordinate = myPosition!
        mapView.addAnnotation(myAnnotation)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    }
    
    @objc func getDirections(){
        let directionReq = MKDirectionsRequest()
        if myPosition == nil {
            myPosition = locationManager.location?.coordinate
        }
        
        if let pin = selectedPin, let me = myPosition {
            let sourceCoordinate = me
            let destCoordinate = pin.coordinate
            
            let soucePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
            let destPlaceMark = MKPlacemark(coordinate: destCoordinate)
            
            let sourceItem = MKMapItem(placemark: soucePlaceMark)
            let destItem = MKMapItem(placemark: destPlaceMark)
            
            directionReq.source = sourceItem
            directionReq.destination = destItem
            directionReq.transportType = transportType
            
            let direction = MKDirections(request: directionReq)
            direction.calculate(completionHandler: { (response, error) in
                guard let response = response else {
                    if let error = error {
                        let noData = UIAlertController(title: "Alert", message: "No roads available \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                        noData.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(noData, animated: true, completion: nil)
                    }
                    return
                }
                self.myRoute = response.routes[0]
                self.kmLablel.text = String(describing: self.myRoute!.distance / 1000) + "Km"
                self.mapView.add(self.myRoute!.polyline, level: .aboveRoads)
                var rekt = self.myRoute!.polyline.boundingMapRect
                rekt.size.width = rekt.size.width * 1.3
                rekt.size.height = rekt.size.height * 1.3
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
            })
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        if let route = myRoute {
            self.mapView.remove((route.polyline))
            kmLablel.text = ""
        }
        if let position = myPosition {
            myAnnotation.coordinate = position
            mapView.addAnnotation(myAnnotation)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint(), size: smallSquare))
        button.setBackgroundImage(UIImage(named: "icons8-teddy-bear-24"), for: .normal)
        button.addTarget(self, action: #selector(self.getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}


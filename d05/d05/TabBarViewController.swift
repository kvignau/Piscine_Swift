//
//  TabBarViewController.swift
//  d05
//
//  Created by Kevin VIGNAU on 10/8/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TabBarViewController: UITabBarController {

    var places: [Place] = []
    var myBool: Bool = true
    var index: Int = 0 {
        didSet {
            self.selectedIndex = 1
        }
    }
    
    func createData() {
        places.append(Place(name: "42", location: CLLocationCoordinate2D(latitude: 48.8967057, longitude: 2.3174013), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1), subtitle: "école de ouf"))
        places.append(Place(name: "Barcelone", location: CLLocationCoordinate2D(latitude: 41.3947847, longitude: 2.1137486), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1), subtitle: "Cataluña"))
        places.append(Place(name: "Montpellier", location: CLLocationCoordinate2D(latitude: 43.6100166, longitude: 3.8391423), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2), subtitle: "Ville étudiante au top"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        self.selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

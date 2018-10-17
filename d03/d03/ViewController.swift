//
//  ViewController.swift
//  d03
//
//  Created by Kevin VIGNAU on 10/4/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageView: UIImageView?
    var image: UIImage?
    let errorUrl: String = "https://cdn2.macworld.co.uk/cmsdata/features/3502310/Temperature.jpg"

    struct AllData {
        static var images : [(String, UIImage?, Bool)] = [
        ("https://www.nasa.gov/sites/default/files/thumbnails/image/expedition_56_landing_181004.jpg", nil, false),
        ("https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss014e13416_large.jpg", nil, false),
        ("https://www.nasa.gov/sites/default/files/thumbnails/image/pia22486-16.jpg", nil, false),
        ("https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss056e096896_0.jpg", nil, false),
        ("test", nil, false),
        ("", nil, false)
        ]
    }
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
 
    func errorAlert(index: Int, url: String) {
        if (AllData.images[index].1 == nil)
        {
            AllData.images[index].2 = false
            AllData.images[index].1 = UIImage(named: "error")
            DispatchQueue.main.async {
                let noData = UIAlertController(title: "Alert", message: "Can't DL Image \(String(describing: url))", preferredStyle: UIAlertControllerStyle.alert)
                noData.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(noData, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllData.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        let url = URL(string: AllData.images[indexPath.row].0)

        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.color = UIColor.black
        activityView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        activityView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        cell.addSubview(activityView)
        queue.async {
            if let goodUrl = url {
                if let imageGet = try? Data(contentsOf: goodUrl) {
                    AllData.images[indexPath.row].2 = true
                    AllData.images[indexPath.row].1 = UIImage(data: imageGet)
                }
                else {
                    self.errorAlert(index: indexPath.row, url: String(describing: goodUrl))
                }
            }
            else {
                self.errorAlert(index: indexPath.row, url: "Empty URL")
            }
            DispatchQueue.main.async {
                activityView.stopAnimating()
                let imageView = UIImageView(image: AllData.images[indexPath.row].1)
                imageView.frame.size = (cell.frame.size)
                cell.backgroundColor = UIColor.black
                cell.addSubview(imageView)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayFullImage")
        {
            if let vc = segue.destination as? displayImage {
                let index = sender as! IndexPath
                guard let sendImage = AllData.images[index.row].1 else { return }
                vc.image = sendImage
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (AllData.images[indexPath.row].2 == true) {
            performSegue(withIdentifier: "displayFullImage", sender: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  displayImage.swift
//  d03
//
//  Created by Kevin VIGNAU on 10/4/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class displayImage: UIViewController, UIScrollViewDelegate {

    var image: UIImage?
    var imageView: UIImageView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.minimumZoomScale = scrollView.bounds.width / image!.size.width;
        if (scrollView.zoomScale < scrollView.minimumZoomScale) {
            scrollView.zoomScale = scrollView.minimumZoomScale;
        }
        scrollView.maximumZoomScale = 100
        scrollView.contentSize = (imageView?.frame.size)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = image
        {
            imageView = UIImageView(image: img)
            scrollView.addSubview(imageView!)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.minimumZoomScale = (size.width / image!.size.width)
        if (scrollView.zoomScale < scrollView.minimumZoomScale) {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        scrollView.maximumZoomScale = 100
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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

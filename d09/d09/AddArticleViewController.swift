//
//  AddArticleViewController.swift
//  d09
//
//  Created by Kevin VIGNAU on 10/12/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import kvignau2018

class AddArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let pickerController = UIImagePickerController()
    var imageData: NSData? = nil
    var article: Articles? = nil
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func Library(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func camera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwindSegue" {
            if let vc = segue.destination as? DiaryViewController {
                let addarticle = article == nil ? vc.articleManager.newArticle() : article
                if addarticle!.createdAt == nil {
                    addarticle!.createdAt = NSDate()
                } else {
                    addarticle!.updateAt = NSDate()
                }
                addarticle!.langue = Locale.current.languageCode
                addarticle!.content = contentText.text
                addarticle!.titre = titleLabel.text
                if let img = self.imageData {
                    addarticle!.image = img
                }
                vc.articleManager.save()
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if ((titleLabel.text?.isEmpty)! || (contentText.text.isEmpty) || (self.imageData == nil && article?.image == nil)) {
            push_notification_alert_error(title: "Fill all the fields", message: "A content is requiered", buttonTitle: "Ok")
            return false
        }
        return true
    }
    
    func push_notification_alert_error(title: String, message: String, buttonTitle: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: {})
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage, let url = info["UIImagePickerControllerImageURL"] as? URL {
            myImageView.image = image
            self.imageData = NSData(contentsOf: url)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        if let ar = article {
            self.title = "Edit Article"
            titleLabel.text = ar.titre
            contentText.text = ar.content
            if let imageData = ar.image as Data? {
                if let image = UIImage(data: imageData) {
                    self.myImageView.image = image
                }
            }
        }
        // Do any additional setup after loading the view.
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

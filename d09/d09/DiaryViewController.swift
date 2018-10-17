//
//  DiaryViewController.swift
//  d09
//
//  Created by Kevin VIGNAU on 10/12/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import kvignau2018

class DiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let articleManager = ArticlesManager()
    var articles: [Articles] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func myUnWindSegue(segue: UIStoryboardSegue) {
        if let segueId = segue.identifier
        {
            if (segueId == "saveUnwindSegue")
            {
                articles = articleManager.getArticles(withLang: Locale.current.languageCode!)
                myTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "editArticle", sender: self.articles[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editArticle")
        {
            if let send = sender as? Articles {
                if let vc = segue.destination as? AddArticleViewController {
                    vc.article = send
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCellTableViewCell
        cell.textContent.text = articles[indexPath.row].content
        cell.titleLabel.text = articles[indexPath.row].titre
        if let imageData = articles[indexPath.row].image as Data? {
            if let image = UIImage(data: imageData) {
                cell.myImageView.image = image
            }
        }
        if let date = articles[indexPath.row].updateAt {
            cell.dateLabel.text = "Updated at : " + date.description
        } else if let createdAt = articles[indexPath.row].createdAt {
            cell.dateLabel.text = "Created at : " + createdAt.description
        } else {
            cell.dateLabel.text = "Date not found"
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articles = articleManager.getArticles(withLang: Locale.current.languageCode!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleManager.removeArticle(article: articles[indexPath.row])
            articleManager.save()
            articles = articleManager.getArticles(withLang: Locale.current.languageCode!)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
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

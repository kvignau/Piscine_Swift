//
//  ViewController.swift
//  kvignau2018
//
//  Created by kvignau on 10/11/2018.
//  Copyright (c) 2018 kvignau. All rights reserved.
//

import UIKit
import kvignau2018

class ViewController: UIViewController {

    let articleManager = ArticlesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let article1 = articleManager.newArticle()
        article1.content = "Hello"
        article1.titre = "I am here"
        article1.langue = "en"
        
        let article2 = articleManager.newArticle()
        article2.content = "je suis la"
        article2.titre = "Bonjour"
        article2.langue = "fr"
        
        let article3 = articleManager.newArticle()
        article3.content = "coucou"
        article3.titre = "je suis un test"
        article3.langue = "fr"
        
        let article4 = articleManager.newArticle()
        article4.content = "Bonne puscine swift :)"
        article4.titre = "swift"
        article4.langue = "suis"

        articleManager.save()
        
        print("Tous les articles :")
        for Entity in articleManager.getArticles() {
            print(Entity.description)
        }
        
        print("\nTous les articles avec la str \"suis\" :")
        for Entity in articleManager.getArticles(containString: "suis") {
            print(Entity.description)
        }
        
        print("\nTous les articles en Anglais :")
        for Entity in articleManager.getArticles(withLang: "en") {
            print(Entity.description)
        }
        
        
        articleManager.removeArticle(article: article3)
        articleManager.removeArticle(article: article1)
        print("\nAprès suppression de 2 articles")
        for Entity in articleManager.getArticles() {
            print(Entity.description)
        }
        articleManager.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


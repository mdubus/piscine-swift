//
//  ViewController.swift
//  mdubus2019
//
//  Created by Morgane DUBUS on 04/05/2019.
//  Copyright (c) 2019 Morgane DUBUS. All rights reserved.
//

import UIKit
import mdubus2019

class ViewController: UIViewController {
    
    let articleManager = ArticleManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("******** create article 1 ********\r\n")
        let article1 = articleManager.newArticle()
        article1.titre = "Article 1"
        article1.langue = "fr"
        article1.content = "Contenu de l'article 1"
        article1.date_creation = Date() as NSDate
        article1.date_modification = Date() as NSDate
        print("\r\n******** article 1 description ********\r\n")
        print(article1.description)
        
        print("\r\n******** create article 2 ********\r\n")
        let article2 = articleManager.newArticle()
        article2.titre = "Article 2"
        article2.langue = "fr"
        article2.content = "\r\nContenu de l'article 2\r\n"
        
        print("\r\n******** create article 3 (en) ********\r\n")
        let article3 = articleManager.newArticle()
        article3.titre = "Article 3 (anglais)"
        article3.langue = "en"

        print("\r\n******** all articles ********\r\n")
        guard let articles = articleManager.getAllArticles() else { return }
        print(articles)

        print("\r\n******** get articles in english ********\r\n")
        guard let enArticles = articleManager.getArticles(withLang : "en") else {return}
        print(enArticles)

        print("\r\n******** get articles containing 'Article 2' ********\r\n")
        guard let article2only = articleManager.getArticles(containString : "Article 2") else {return}
        print(article2only)
        
        print("\r\n******** removing article 2 ********\r\n")
        articleManager.removeArticle(article : article2)
        guard let allArticles = articleManager.getAllArticles() else { return }
        print("\r\n******** print all articles ********\r\n")
        print(allArticles)
        
        print("\r\n******** saving ********\r\n")
        articleManager.save()
        
//        guard let allArticles = articleManager.getAllArticles() else { return }
//        print("\r\n******** print all articles ********\r\n")
//        print(allArticles)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


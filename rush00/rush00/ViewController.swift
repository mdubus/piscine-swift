//
//  ViewController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit
import WebKit


let UID = "YouWontHaveMyUID"
let SECRET = "YouWontHaveMySecret"
let STATE = "Yolo"
let APIBASE = "https://api.intra.42.fr/v2"
let authURL = "https://api.intra.42.fr/oauth/token"
let grantType = "authorization_code"
let redirectURI = "https://www.42.fr"
let signInURL = "https://signin.intra.42.fr"
let signOutURL = "https://signin.intra.42.fr/users/sign_out"
var TOKEN = ""
var USERID = ""

class ViewController: UIViewController, WKNavigationDelegate {
    
    var code:String = ""
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    func manageError(_ error: String) {
        
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
//        getUserID()
//        print(USERID)
    }
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        guard let responseURL = webView.url else {return }
        let isSignInPage = responseURL.absoluteString.contains(signInURL)
        
        if isSignInPage == false {
            guard let urlComp = URLComponents(string:responseURL.absoluteString) else {
                manageError("Something went wrong")
                return
            }
            
            if let code = urlComp.queryItems?.first(where: { $0.name == "code" })?.value  {
                webView.stopLoading()
                self.code = code
                self.exchangeCodeForToken()
            }
            
            if (urlComp.queryItems?.first(where: { $0.name == "error" })?.value) != nil  {
                webView.stopLoading()
               self.manageError("Access denied")
            }
        }
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https";
        components.host = "api.intra.42.fr";
        components.path = "/oauth/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: UID),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "state", value: STATE),
            URLQueryItem(name: "scope", value: "public forum"),
        ]
        
        var myRequest = URLRequest(url: components.url!)
        webView.load(myRequest)
        
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
        print("Logout")
        TOKEN = ""

        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("42") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                        DispatchQueue.main.async {
                            self.webView.reload()
                        }
                    })
                }
            }
        }
    }
    
    
    func exchangeCodeForToken() {
        var components = URLComponents()
        components.scheme = "https";
        components.host = "api.intra.42.fr";
        components.path = "/oauth/token"
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: grantType),
            URLQueryItem(name: "client_id", value: UID),
            URLQueryItem(name: "client_secret", value: SECRET),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "state", value: STATE),
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        
        let getData = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(TokenAPI.self, from: d)
                    guard let userToken = result.access_token else {
                        self.manageError("Login failed")
                        return
                    }
                    TOKEN = userToken
                }
                catch (let err) {
                    print(err)
                }
            }
            DispatchQueue.main.async {
                guard let topicsVC = self.storyboard?.instantiateViewController(withIdentifier: "TopicList") as? TopicViewController else {return }
                self.navigationController?.pushViewController(topicsVC, animated: true)
            }
        }
        getData.resume()
        
    }
    
    
    
    
    
    
    
    
    
    
}


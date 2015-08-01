//
//  RADWikiViewController.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

import UIKit

class RADWikiViewController: UIViewController, UIWebViewDelegate {
    
    var model: RADSwChar?
    var canLoad: Bool?
    @IBOutlet weak var browser: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    convenience init(model: RADSwChar?){
        self.init(nibName: "RADWikiViewController", bundle: nil)
        self.model = model
        self.title = "Wikipedia"
        self.canLoad = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notifyThatCharacterDidChange:"), name: CHARACTER_DID_CHANGE_NOTIFICATION, object: nil)
        
        self.edgesForExtendedLayout = .None
        
        //SINCRONIZAR VISTA Y MODELO
        self.syncViewWithModel()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.hidesBackButton = false
        
        // ASIGNAMOS DELEGADO
        browser.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // TEAR DOWN NOTIFICATION
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIWebViewDelegate
    // DELEGADO WEBVIEW
    func webViewDidFinishLoad(webView: UIWebView) {
        // Paro y oculto el activity
        activityView.stopAnimating()
        activityView.hidden = true
        
        canLoad = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        // Paro y oculto el activity
        activityView.stopAnimating()
        activityView.hidden = true
    }
    
    // MARK: - Notificacion (CHARACTER_DID_CHANGE_NOTIFICATION)
    func notifyThatCharacterDidChange(notification: NSNotification){
        
        // Sacamos el personaje
        if let info: NSDictionary = notification.userInfo,
            let character = info.objectForKey(CHARACTER_KEY) as? RADSwChar{
                model = character
        }
        
        // SINCRONIZAMOS
        self.syncViewWithModel()
    }
    
    // MARK: - Utiles varios
    func syncViewWithModel(){
        canLoad = true
        
        activityView.hidden = false
        activityView.startAnimating()
        
        if let miModel = model,
            let url = miModel.wikiURL{
                browser.loadRequest(NSURLRequest(URL: url))
        }
    }
    
}

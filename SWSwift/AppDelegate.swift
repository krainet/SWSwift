//
//  AppDelegate.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Valor por defecto para último personaje seleccionado
        let defaults = NSUserDefaults.standardUserDefaults()
        let last: AnyObject? = defaults.objectForKey(LAST_SELECTED_CHARACTER)
        
        if let lastSelected: AnyObject = last {
            
        }else{
            defaults.setObject([SECCION_IMPERIAL, 0], forKey: LAST_SELECTED_CHARACTER)
            defaults.synchronize()
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Creamos un modelo
        let universe: RADSwUniv = RADSwUniv()
        
        // Detectamos el tipo de pantalla
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad{
            // Tipo tableta
            self.configureForPad(universe)
        }else{
            // Tipo telefono
            self.configureForPhone(universe)
        }
        
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
        
    }
    
    func configureForPad(universe: RADSwUniv){
        // Creamos los controladores
        let uVC = RADUnivTableViewController(model: universe)
        let charVC = RadCharViewController(model: self.lastSelectedCharacterInModel(universe))
        
        // Creamos los navigation
        let uNav = UINavigationController(rootViewController: uVC)
        let charNav = UINavigationController(rootViewController: charVC)
        
        // Creamos el combinador
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [uNav, charNav]
        
        // Asignamos delegados
        splitVC.delegate = charVC
        uVC.delegate = charVC
        
        // Lo hago root
        self.window?.rootViewController = splitVC
    }
    
    func configureForPhone(universe: RADSwUniv){
        // Creamos el controlador
        let uVC = RADUnivTableViewController(model: universe)
        
        // Creamos el combinador
        let uNav = UINavigationController(rootViewController: uVC)
        
        // Asignamos delegados
        uVC.delegate = uVC
        
        // Lo hago root
        self.window?.rootViewController = uNav
    }
    
    func lastSelectedCharacterInModel(universe: RADSwUniv) -> RADSwChar?{
        // Obtengo NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Saco las coordenadas del ultimo personaje
        if let coords: NSArray = defaults.objectForKey(LAST_SELECTED_CHARACTER) as? NSArray{
            let section = coords.objectAtIndex(0).integerValue
            let pos = coords.objectAtIndex(1).integerValue
            
            // Obtengo el personaje
            var character: RADSwChar?
            if section == SECCION_IMPERIAL{
                character = universe.imperialAtIndex(pos)
            }else{
                character = universe.rebelAtIndex(pos)
            }
            return character
        }
        return RADSwChar(alias: nil, wikiURL: nil, soundData: nil, photo: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


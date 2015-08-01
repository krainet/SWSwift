//
//  RADCharViewController.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class RadCharViewController: UIViewController, UISplitViewControllerDelegate, RADUnivTableViewControllerDelegate {
    
    var model: RADSwChar?
    var cafPlayer: CafPlayer?
    @IBOutlet weak var photoView: UIImageView!
    
    // MARK: Inicializadores
    convenience init(model: RADSwChar?){
        self.init(nibName: "RADCharViewController", bundle: nil)
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.edgesForExtendedLayout = .None
        
        // Sincronizar modelo -> vista
        self.syncVM()
        
        // Si estoy dentro de un SplitVC me pongo el botón
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func goToWeb(sender: UIBarButtonItem) {
        // Crear un VC y hacemos push
        let wVC = RADWikiViewController(model: model)
        self.navigationController?.pushViewController(wVC, animated: true)
    }
    
    @IBAction func playMusic(sender: UIBarButtonItem) {
        if let miModel = self.model,
            let soundData = miModel.soundData{
                cafPlayer = CafPlayer.cafPlayer() as? CafPlayer
                if let player = cafPlayer{
                    player.playSoundData(soundData)
                }
        }
    }
    
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        if displayMode == UISplitViewControllerDisplayMode.PrimaryHidden{
            self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
        }else{
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    // MARK: - RADUniverseTableViewControllerDelegate
    func universeTableViewController(uVC: RADUnivTableViewController, didSelectCharacter: RADSwChar) {
        self.model = didSelectCharacter
        self.syncVM()
    }
    
    
    // MARK: - Utiles varios
    
    func syncVM(){
        if let myModel = self.model{
            self.title = myModel.alias
            if let photo = myModel.photo{
                photoView.image = photo
            }
        }
    }
    
    
}

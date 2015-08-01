//
//  RADUnivTableViewController.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

import UIKit

protocol RADUnivTableViewControllerDelegate{
    func universeTableViewController(uVC: RADUnivTableViewController, didSelectCharacter: RADSwChar)
}

class RADUnivTableViewController: UITableViewController, RADUnivTableViewControllerDelegate{
    
    var model: RADSwUniv?
    var delegate: RADUnivTableViewControllerDelegate?
    
    convenience init(model: RADSwUniv?){
        self.init(nibName: nil, bundle: nil)
        self.model = model
        self.title = "Universo Starwars"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Datasource Tabla
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model: RADSwUniv = self.model{
            if section == SECCION_IMPERIAL{
                return model.imperialCount
            }else{
                return model.rebelCount
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SECCION_IMPERIAL{
            return "Imperiales"
        }else{
            return "Rebeldes"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var miCell: UITableViewCell
        if let cell = tableView.dequeueReusableCellWithIdentifier("StarWarsCell") as? UITableViewCell{
            miCell = cell
        }else{
            miCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "StarWarsCell")
        }
        
        
        // TIPO Y CHAR SELECCIONADO
        let character: RADSwChar?
        if let model: RADSwUniv = self.model{
            if indexPath.section == SECCION_IMPERIAL{
                character = model.imperialAtIndex(indexPath.row)
            }else{
                character = model.rebelAtIndex(indexPath.row)
            }
            if let char = character{
                // SYNC
                myCell.imageView?.image = char.photo
                myCell.textLabel?.text = char.alias
                myCell.detailTextLabel?.text = char.name
            }
        }
        
        return myCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let character: RADSwChar?
        if let model: RADSwUniv = self.model{
            
            // SELECCIONAR TIPO Y CARACTER
            if indexPath.section == SECCION_IMPERIAL{
                character = model.imperialAtIndex(indexPath.row)
            }else{
                character = model.rebelAtIndex(indexPath.row)
            }
            if let char = character{
                
                // AVISAR DELEGADO
                if let del = self.delegate{
                    del.universeTableViewController(self, didSelectCharacter: char)
                }
                
                // SEND NOTIFICATION
                let nc = NSNotificationCenter.defaultCenter()
                let dict = [CHARACTER_KEY : char]
                let n = NSNotification(name: CHARACTER_DID_CHANGE_NOTIFICATION, object: self, userInfo: dict)
                nc.postNotification(n)
                
                // GUARDADO EN NSUSERDEFAULTS
                let coords = [indexPath.section, indexPath.row]
                let def = NSUserDefaults.standardUserDefaults()
                def.setObject(coords, forKey: LAST_SELECTED_CHARACTER)
                def.synchronize()
            }
        }
    }
    
    // MARK: - RADUniverseTableViewControllerDelegate
    func universeTableViewController(uVC: RADUnivTableViewController, didSelectCharacter: RADSwChar) {
        
        // CREAR CHAR VC
        let charVC = RadCharViewController(model: didSelectCharacter)
        self.navigationController?.pushViewController(charVC, animated: true)
    }
    
}

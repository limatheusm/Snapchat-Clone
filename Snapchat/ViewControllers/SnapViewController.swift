//
//  SnapViewController.swift
//  Snapchat
//
//  Created by Matheus Lima on 24/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
    
    let firebaseService: FirebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sair(_ sender: Any) {
        do {
            try self.firebaseService.auth.signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch {
            
        }
    }
}

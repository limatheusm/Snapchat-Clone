//
//  Alerta.swift
//  Snapchat
//
//  Created by Matheus Lima on 25/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class Alerta {
    
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    func getAlerta() -> UIAlertController {
        let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: .alert)
        let acaoConfirmar = UIAlertAction(title: "Entendi", style: .default, handler: nil)
        alert.addAction(acaoConfirmar)
        return alert
    }
}

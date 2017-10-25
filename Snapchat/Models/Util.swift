//
//  Util.swift
//  Snapchat Clone
//
//  Created by Matheus Lima on 23/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class Util {
    
    func exibirMensagem(titulo: String, mensagem: String, view: UIViewController) {
        
        view.present(alert, animated: true, completion: nil)
    }
}

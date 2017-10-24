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
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoConfirmar = UIAlertAction(title: "Entendi", style: .default, handler: nil)
        alert.addAction(acaoConfirmar)
        view.present(alert, animated: true, completion: nil)
    }
}

//
//  EntrarViewController.swift
//  Snapchat Clone
//
//  Created by Matheus Lima on 22/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class EntrarViewController: UIViewController {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputSenha: UITextField!
    let firebaseService = FirebaseService()
    let util: Util = Util()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func logar(_ sender: Any) {
        if let email = self.inputEmail.text {
            if let senha = self.inputSenha.text {
                self.firebaseService.auth.signIn(withEmail: email, password: senha, completion: { (user, error) in
                    if error == nil {
                        if user == nil {
                            // Usuario nao esta logado
                            self.util.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente", view: self)
                        }
                        else {
                            // Sucesso
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }
                    else {
                        self.util.exibirMensagem(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados", view: self)
                    }
                })
            }
        }
    }
}

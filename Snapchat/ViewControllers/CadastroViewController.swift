//
//  CadastroViewController.swift
//  Snapchat Clone
//
//  Created by Matheus Lima on 22/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputSenha: UITextField!
    @IBOutlet weak var inputConfirmarSenha: UITextField!
    let firebaseService: FirebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        if let email = self.inputEmail.text {
            if let senha = self.inputSenha.text {
                if let confirmarSenha = self.inputConfirmarSenha.text {
                    if senha == confirmarSenha {
                        // Criar conta no Firebase
                        self.firebaseService.auth.createUser(withEmail: email, password: senha, completion: { (user, error) in
                            if error == nil {
                                if user == nil {
                                    self.present(Alerta(title: "Erro ao autenticar", message: "Problema ao realizar autenticação, tente novamente").getAlerta(), animated: true)
                                }
                                else {
                                    self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                }
                            }
                            else {
                                let mensagemErro = self.firebaseService.tratarErroCadastro(error: error)
                                self.present(Alerta(title: "Ops!", message: mensagemErro).getAlerta(), animated: true)
                            }
                        })
                    }
                    else {
                        self.present(Alerta(title: "Ops!", message: "As senhas precisam ser iguais!").getAlerta(), animated: true)
                    }/*Fim validacao senha*/
                }
            }
        }
    }

}

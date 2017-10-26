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
    @IBOutlet weak var inputNome: UITextField!
    
    let firebaseService: FirebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Esconder teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        if let email = self.inputEmail.text {
            if let senha = self.inputSenha.text {
                if let nome = self.inputNome.text {
                    if let confirmarSenha = self.inputConfirmarSenha.text {
                        if senha == confirmarSenha {
                            if !nome.isEmpty {
                                // Criar conta no Firebase
                                self.firebaseService.auth.createUser(withEmail: email, password: senha, completion: { (user, error) in
                                    if error == nil {
                                        if user == nil {
                                            self.present(Alerta(title: "Erro ao autenticar", message: "Problema ao realizar autenticação, tente novamente").getAlerta(), animated: true)
                                        }
                                        else {
                                            // Cria referencia(no) no banco de dados
                                            let usuarios = self.firebaseService.database.child("usuarios")
                                            // Recupera o uid do usuario autenticado e cria um no no database
                                            // Apos isso, salva o Dictionare usuario (Objeto swift nao suportado pelo firebase)
                                            usuarios.child(user!.uid).setValue([
                                                "nome": nome,
                                                "email": email
                                                ])
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
                                self.present(Alerta(title: "Ops!", message: "Voce esqueceu de nos dizer seu nome!").getAlerta(), animated: true)
                            }
                        }
                        else {
                            self.present(Alerta(title: "Ops!", message: "As senhas precisam ser iguais!").getAlerta(), animated: true)
                        }/*Fim validacao senha*/
                    }
                }
            }
        }
    }
    
}

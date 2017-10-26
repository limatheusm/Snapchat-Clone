//
//  FirebaseService.swift
//  Snapchat Clone
//
//  Created by Matheus Lima on 22/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FirebaseService {
    
    let auth: Auth
    let storage: StorageReference
    let database: DatabaseReference
    
    init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage().reference()
        self.database = Database.database().reference()
    }
    
    func tratarErroCadastro(error: Error?) -> String {
        let erro = error! as NSError
        var mensagemErro = ""
        if let codigoErro = erro.userInfo["error_name"] {
            let erroTexto = codigoErro as! String
            switch erroTexto {
                case "ERROR_INVALID_EMAIL":
                    mensagemErro = "E-mail invalido, digite um email valido!"
                    break
                case "ERROR_WEAK_PASSWORD":
                    mensagemErro = "Senha precisa ter no minimo 6 caracteres, com letras e numeros"
                    break
                case "ERROR_EMAIL_ALREADY_IN_USE":
                    mensagemErro = "Este e-mail ja esta sendo utilizado, crie sua conta com outro e-mail"
                    break
                default:
                    mensagemErro = "Houve um erro, tente novamente mais tarde."
                    break
            }
        }
        
        return mensagemErro
    }
}


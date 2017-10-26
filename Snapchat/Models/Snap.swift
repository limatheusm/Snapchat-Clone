//
//  Snap.swift
//  Snapchat
//
//  Created by Matheus Lima on 26/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import Foundation

class Snap {
    
    var identificador: String
    var nome: String
    var de: String
    var descricao: String
    var urlImagem: String
    var idImagem: String
    
    init(identificador: String, nome: String, de: String, descricao: String, urlImagem: String, idImagem: String) {
        self.identificador = identificador
        self.nome = nome
        self.de = de
        self.descricao = descricao
        self.urlImagem = urlImagem
        self.idImagem = idImagem
    }
    
    init() {
        self.identificador = ""
        self.nome = ""
        self.de = ""
        self.descricao = ""
        self.urlImagem = ""
        self.idImagem = ""
    }
}

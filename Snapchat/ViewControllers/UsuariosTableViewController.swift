//
//  UsuariosTableViewController.swift
//  Snapchat
//
//  Created by Matheus Lima on 25/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsuariosTableViewController: UITableViewController {
    
    var usuarios: [User] = []
    var urlImagem: String = ""
    var descricaoImagem: String = ""
    var idImagem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let usuariosRef = FirebaseService().database.child("usuarios")
        // Adiciona evento novo usuario adicionado
        usuariosRef.observe(DataEventType.childAdded) { (snapshot) in
            // Converte os dados para dicionario
            let dados = snapshot.value as? NSDictionary
            // Recuperar os dados
            let emailUser = dados?["email"] as! String
            let nomeUser = dados?["nome"] as! String
            let idUser = snapshot.key
            // Adicionar a lista de usuarios para exibir na tabela
            self.usuarios.append(User(email: emailUser, nome: nomeUser, uid: idUser))
            
            // Atualiza tabela
            self.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usuarios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = self.usuarios[indexPath.row].nome
        cell.detailTextLabel?.text = self.usuarios[indexPath.row].email
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Recupera usuario selecionado no qual enviaremos o snap
        let usuarioSelecionado = self.usuarios[indexPath.row]
        let idUsuarioSelecionado = usuarioSelecionado.uid
        // Recupera referencia do No do database
        let usuariosRef = FirebaseService().database.child("usuarios")
        let snapsRef = usuariosRef.child(idUsuarioSelecionado).child("snaps")
        // Recupera dados do usuario logado
        if let idUsuarioLogado = FirebaseService().auth.currentUser?.uid {
            let usuarioLogado = usuariosRef.child(idUsuarioLogado)
            // Recupera dados com evento unico
            usuarioLogado.observeSingleEvent(of: .value, with: { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                // Salva snap
                snapsRef.childByAutoId().setValue([
                    "de" : dados?["email"] as! String,
                    "nome" : dados?["nome"] as! String,
                    "descricao" : self.descricaoImagem,
                    "urlImagem" : self.urlImagem,
                    "idImagem" : self.idImagem,
                ])
                
            })
        }
    } 
}

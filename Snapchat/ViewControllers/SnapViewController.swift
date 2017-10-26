//
//  SnapViewController.swift
//  Snapchat
//
//  Created by Matheus Lima on 24/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let firebaseService: FirebaseService = FirebaseService()
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Recupera id Usuario Logado
        if let idUsuarioLogado = self.firebaseService.auth.currentUser?.uid {
            let usuariosRef = self.firebaseService.database.child("usuarios")
            let snaps = usuariosRef.child(idUsuarioLogado).child("snaps")
            
            // Cria ouvinte para Snaps ao um snap ser adicionado
            snaps.observe(.childAdded, with: { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                self.snaps.append(Snap(
                    identificador: snapshot.key,
                    nome: dados?["nome"] as! String,
                    de: dados?["de"] as! String,
                    descricao: dados?["descricao"] as! String,
                    urlImagem: dados?["urlImagem"] as! String,
                    idImagem: dados?["idImagem"] as! String
                ))
                // Recarrega tabela
                self.tableView.reloadData()
            })
            // Ouvinte ao remover um snap
            snaps.observe(.childRemoved, with: { (snapshot) in
                // Remove do array de snaps
                var index = 0
                for snap in self.snaps {
                    if snap.identificador == snapshot.key {
                        self.snaps.remove(at: index)
                    }
                    index += 1
                }
                
                self.tableView.reloadData()
            })
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snaps.count == 0 ? 1 : self.snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        cell.textLabel?.text = self.snaps.count == 0 ? "Nenhum snap para voce ):" : self.snaps[ indexPath.row ].nome
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.snaps.count > 0 {
            self.performSegue(withIdentifier: "detalhesSnapSegue", sender: self.snaps[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesSnapSegue" {
            let detalhesSnapViewController = segue.destination as! DetalhesSnapViewController
            detalhesSnapViewController.snap = sender as! Snap
        }
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

//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Matheus Lima on 26/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit
import SDWebImage

class DetalhesSnapViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var labelContador: UILabel!
    let firebaseService: FirebaseService = FirebaseService()
    var snap: Snap = Snap()
    var tempo = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.labelDescricao.text = "Carregando snap..."
        self.imagem.sd_setImage(with: URL(string: self.snap.urlImagem)) { (img, error, cache, url) in
            if error == nil {
                // Snap carregado!!
                self.labelDescricao.text = self.snap.descricao
                // Inicializa timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    self.tempo -= 1
                    self.labelContador.text = String(self.tempo)
                    if (self.tempo == 0) {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Ao fechar a view, apagar o snap do banco de dados
        if let idUsuarioLogado = self.firebaseService.auth.currentUser?.uid {
            let usuariosRef = self.firebaseService.database.child("usuarios")
            let snaps = usuariosRef.child(idUsuarioLogado).child("snaps")
            // Removendo o snap
            snaps.child(self.snap.identificador).removeValue()
            
            // Removendo snap do Storage
            let imagensRef = self.firebaseService.storage.child("imagens")
            imagensRef.child("\(self.snap.idImagem).jpg").delete(completion: { (error) in
                if error == nil {
                    print("Sucesso ao excluir")
                }
                else {
                    print("erro ao remover o snap no storage")
                }
            })
            
        }
    }
}

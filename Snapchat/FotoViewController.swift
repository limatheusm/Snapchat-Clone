//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Matheus Lima on 24/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{

    @IBOutlet weak var inputDescricao: UITextField!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var botaoEnviar: UIButton!
    
    let imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    let firebaseService: FirebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.botaoEnviar.isEnabled = false
        self.botaoEnviar.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        self.imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func escolherFoto(_ sender: Any) {
        //imagePicker.sourceType = .camera
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imagem.image = imgRecuperada
        // Habilita o botao enviar
        self.botaoEnviar.isEnabled = true
        self.botaoEnviar.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enviar(_ sender: Any) {
        self.botaoEnviar.isEnabled = false
        self.botaoEnviar.setTitle("Carregando...", for: .normal)
        
        // Salvar dados no storage Firebase
        let imagens = self.firebaseService.storage.child("imagens") // Pasta imagens no storage
        if let imgSelecionada = self.imagem.image {
            if let imgDados = UIImageJPEGRepresentation(imgSelecionada, 0.1) {
                imagens.child("\(self.idImagem).jpg").putData(imgDados, metadata: nil, completion: { (metadados, error) in
                    if error == nil {
                        print("Sucesso")
                        //print(metadados?.downloadURL()?.absoluteString)
                        //self.botaoEnviar.isEnabled = true
                        self.botaoEnviar.setTitle("Enviado!", for: .normal)
                    }
                    else {
                        print("Fail")
                    }
                })
            }
        }
    }
}

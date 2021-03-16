//
//  ViewController.swift
//  HW-4
//
//  Created by Ferda Öztürk on 23.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let db = DataBase()
    
    @IBOutlet weak var txtUrun: UITextField!
    @IBOutlet weak var txtMiktar: UITextField!
    @IBAction func btnEkle(_ sender: UIButton) {
        
        let urun = txtUrun.text!
        let miktar = txtMiktar.text!
        
        let row = db.urunInsert(urun: urun, miktar: miktar)
        print(row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.fncConneciton()
        // Do any additional setup after loading the view.
    }


}


//
//  DataBase.swift
//  HW-4
//
//  Created by Ferda Öztürk on 23.01.2021.
//

import Foundation
import SQLite

struct AlinacaklarSt {
    
    var urun = ""
    var miktar = ""
}

class DataBase {
    
    var db:Connection!
    var tableAlinacaklar = Table("urun")
    
    let urun = Expression<String>("urun")
    let miktar = Expression<String>("miktar")
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    func fncConneciton(){
        
        let dbPath = path + "/db.sqlite3"
        print("Full Path : \(dbPath)")
        db = try! Connection(dbPath)
        
        do {
            try db.scalar(tableAlinacaklar.exists)
            
        } catch  {
            
            try! db.run(tableAlinacaklar.create { t in
                
                t.column(urun)
                t.column(miktar)
                
            })
            
        }
    }
    
    func urunInsert(urun: String, miktar: String) -> Int64 {
        do {
            let insert = tableAlinacaklar.insert( self.urun <- urun, self.miktar <- miktar )
            return try db.run(insert)
        } catch  {
            return -1
        }

    }
    
    func urunList() -> [AlinacaklarSt] {
        var arr:[AlinacaklarSt] = []
        
        let bilgiler = try! db.prepare(tableAlinacaklar) //tablo içindeki tüm bilgiler gelir
        for item in bilgiler {
            print(item[urun])
            let us = AlinacaklarSt(urun: item[urun], miktar: item[miktar])
            arr.append(us)
        }
        return arr
    }
    
    func urunDelete (uUrun: String ) -> Int {
        let alice = tableAlinacaklar.filter(urun == uUrun)
        return try! db.run(alice.delete())
    }
    
}

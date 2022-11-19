//
//  CalcTotal.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 05/11/2022.
//

import Foundation

class CalcTotal{
    
    func calcTotalPrice(){
        var total = 0.0
        do {
            let items = try context.fetch(Cart.fetchRequest())
            for i in items {
                let quantity = NSString(string: i.quantity!)
                let price = NSString(string: i.price!)
                total += quantity.doubleValue * price.doubleValue
            }
            UserDefaults.standard.set(total, forKey: "TotalPrice")
            print("total \(UserDefaults.standard.double(forKey: "TotalPrice"))")
        }
        catch let error {
            print(error)
        }
    }
    
    func calcTotalQuantity(){
        var total = 0.0
        do {
            let items = try context.fetch(Cart.fetchRequest())
            for i in items {
                let quantity = NSString(string: i.quantity!)
                total += quantity.doubleValue
            }
            UserDefaults.standard.set(total, forKey: "TotalQuantity")
            print("TotalQuantity \(UserDefaults.standard.double(forKey: "TotalQuantity"))")
        }
        catch let error {
            print(error)
        }
    }

}

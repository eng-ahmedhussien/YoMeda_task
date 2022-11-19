//
//  CoreDataManger.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 05/11/2022.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager{
    static let sharedInstance = CoreDataManager()
    private init(){}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
extension CoreDataManager {

    func delete<T: NSManagedObject>(returnType: T.Type, delete: T) {
        context.delete(delete.self)
        do {
            try context.save()
            
        }catch {
            print("Products not deleted", error)
        }
    }
    
    func getSelectedItemFromCart(product:Complaint, completion: @escaping (Cart?, Error?)-> Void){
        
        do {
            let arrayOfProduct = try context.fetch(Cart.fetchRequest())
            for item in arrayOfProduct {
                if item.id == product.id{
                    completion(item, nil)
                }
            }
        } catch let error {
            completion(nil, error)
        }
    }
    
    func addItemsToCart(product:Complaint){
        if isItemInCart(productId: product.id!){
            print("Already in cart")
        }else{
            let item = Cart(context: context)
            item.id = product.id
            item.name = product.englishName
            item.price = "\(product.price!)"
            item.image = product.picURL
            item.quantity = "\(1)"
            try? context.save()
        }
    }
    
    func isItemInCart(productId:String) -> Bool {
        var check : Bool = false
        
        do {
            let items = try context.fetch(Cart.fetchRequest())
            for i in items {
                if i.id == productId {
                    check = true
                    break
                }else {
                    check = false
                }
            }
        } catch let error {
            print(error)
        }
        return check
    }

    func isCartEmpty()->Bool{
        var check : Bool = false
        do {
            let items = try context.fetch(Cart.fetchRequest())
            check  = items.count == 0 ? true : false
        } catch let error {
            print(error)
        }
        return check
    }
    


  
}

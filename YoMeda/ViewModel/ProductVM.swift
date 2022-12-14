//
//  ProductVM.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 22/10/2022.
//

import Foundation
import CoreData

class ProductVM{
    
    //MARK: - network functions
    var productsArray: [Complaint]? {
        didSet{
            updateData(productsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    let ApiService: NetworkManager
    var updateData : (([Complaint]?,Error?) -> Void) = {_ , _ in}
    init(ApiService: NetworkManager = NetworkManager()) {
        self.ApiService = ApiService
    }
    func fetchData(searchkey:String){
        ApiService.networkPost(completion: { products, error in
            if let products = products{
                self.productsArray = products
            }else{
                self.error = error
            }
        }, searchkey: searchkey)
    }
}

//
//  ProductVM.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 22/10/2022.
//

import Foundation
import CoreData
import Combine

class ProductVM{

    //MARK: - network functions
    var productsArray: [Complaint]? {
        didSet{
            bindingData(productsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let ApiService: NetworkManager
    var bindingData : (([Complaint]?,Error?) -> Void) = {_ , _ in}
    init(ApiService: NetworkManager = NetworkManager()) {
        self.ApiService = ApiService
    }
//    func fetchData(searchkey:String){
//        ApiService.networkPost(completion: { products, error in
//            if let products = products{
//                self.productsArray = products
//            }else{
//                self.error = error
//            }
//        }, searchkey: searchkey)
//    }
    
    //MARK: - combine
    func fetchData(searchkey:String)-> Future<[Complaint],Error>{
        return Future { data in
            self.ApiService.networkPost(completion: { products, error in
                if let products = products{
                    data(.success(products))
                   // self.productsArray = products
                }else{
                    data(.failure(error!))
                   // self.error = error
                }
            }, searchkey: searchkey)
        }
    }
    
}

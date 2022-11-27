//
//  Url.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 22/10/2022.
//

import Foundation
struct Url {
    static let shared = Url()
    let baseURL = "http://40.127.194.127:5656/Salamtak/GetMedicationItems"
    let param  = [
        "indexFrom" : "1",
        "indexTo" : "10",
        "serchKey" : "pan"
    ]
    
    func getAllUsers()-> URL?{
        return URL(string: baseURL + "user")
    }
    func getAllPosts()-> URL?{
        return URL(string: baseURL + "post")
    }

}
struct UrlServices {
    var endPoint: String = ""
    var URL : String{
        return "http://40.127.194.127:5656/Salamtak/GetMedicationItems\(endPoint)"
    }

}

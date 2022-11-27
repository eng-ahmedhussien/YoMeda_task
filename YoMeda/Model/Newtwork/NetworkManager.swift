//
//  NetworkManager.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 22/10/2022.
//

import Foundation


class NetworkManager{
    func networkPost(completion: @escaping ([Complaint]?, Error?) -> (),searchkey:String){
        guard let url = URL(string: Url.shared.baseURL) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // request.httpShouldHandleCookies = false
        let postString = "indexFrom=1&indexTo=10&serchKey=\(searchkey)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,let response = response as? HTTPURLResponse,error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(Posts.self, from: data)
                let productArray = responseObject.complaints
                DispatchQueue.main.async
                {
                    completion(productArray,nil)
                }
               
            }
            catch {
                print(error)
                DispatchQueue.main.async
                {
                    completion(nil,error)// parsing error
                }
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
            
        }
        task.resume()

    }

}

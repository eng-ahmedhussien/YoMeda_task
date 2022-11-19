//
//  Alert.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 05/11/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertExit (title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default) { alert in
            exit(0)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(title:String, message:String, complition:@escaping (Bool)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
        let confirmBtn = UIAlertAction(title: "Confirm".localized, style: .destructive) { _ in
            complition(true)
        }
        alert.addAction(cancelBtn)
        alert.addAction(confirmBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

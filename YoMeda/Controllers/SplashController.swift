//
//  SplashController.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 21/10/2022.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            let toHomeView = self.storyboard?.instantiateViewController(identifier:"ViewController") as? ViewController
            let nav = UINavigationController(rootViewController: toHomeView!)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
 

}

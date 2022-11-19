//
//  ProductCell.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 21/10/2022.
//

import UIKit
import Kingfisher


class ProductCell: UITableViewCell {

    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantityButtons: UIStackView!
    @IBOutlet weak var productQuantity: UILabel!
    
    let productVM = ProductVM()
    var product : Complaint?
    var addItemQuantity : (()->())?
    var subItemQuantity : (()->())?
    var fristAddItemToCart : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCartButton.setTitle("addـcart".localized, for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addCart(_ sender: Any) {
        addCartButton.isHidden = true
        quantityButtons.isHidden = false
        guard let product = product else{return}
        CoreDataManager.sharedInstance.addItemsToCart(product:product)
       // productVM.addItemsToCart(product: product)
        fristAddItemToCart?()
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        addItemQuantity?()
    }
    
    @IBAction func minusButton(_ sender: Any) {
        subItemQuantity?()
    }
    
    func prepareCell(cell:Complaint){
        //check if in cart
        if CoreDataManager.sharedInstance.isItemInCart(productId:cell.id!){
            addCartButton.isHidden = true
            quantityButtons.isHidden = false
        }else{
            addCartButton.isHidden = false
            quantityButtons.isHidden = true
        }
        CoreDataManager.sharedInstance.getSelectedItemFromCart(product:cell) { selectedItem, error in
            if selectedItem != nil {
                self.productQuantity.text = "\(selectedItem?.quantity ?? "0" )"
            }
        }
//        productVM.getSelectedItemFromCart(product:cell) { selectedItem, error in
//            if selectedItem != nil {
//                self.productQuantity.text = "\(selectedItem?.quantity ?? "0" )"
//            }
//        }
        let  currentLanguage = Locale.current.language.languageCode!.identifier
        if currentLanguage == "en"{
            productName.text = cell.englishName
        }else{
            productName.text = cell.arabicName
        }
        productPrice.text = "\(cell.price ?? 0.0)"
        
        if  let url = URL(string: cell.picURL!){
            let task =  URLSession.shared.dataTask(with: url){ data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self!.productImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
        
//        let  placeimage = UIImage(named:"product-placeholder-wp")
//        productImage.kf.setImage(with: url,placeholder: placeimage)
        
        
    }

}


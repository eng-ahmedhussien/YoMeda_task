//
//  cartCell.swift
//  
//
//  Created by Ahmed Hussien on 23/10/2022.
//

import UIKit

class cartCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var producprice: UILabel!
    @IBOutlet weak var qantityLabel: UILabel!
    
    
    let productVM = ProductVM()
    let calcTotal = CalcTotal()
    var addItemQuantity : (()->())?
    var subItemQuantity : (()->())?
    var updateTotalPriceInCart : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(cell:Cart){
        
        qantityLabel.text = "\(cell.quantity ?? "0" )"
        productName.text = cell.name
        producprice.text = cell.price
        
        let url = URL(string: cell.image!)
        let  placeimage = UIImage(named:"product-placeholder-wp")
        productImage.kf.setImage(with: url,placeholder: placeimage)
        
        
        addItemQuantity = {
            cell.quantity  = "\(Double((cell.quantity)!)!+1)"
            try? context.save()
            self.qantityLabel.text = "\(cell.quantity ?? "0" )"
           // self.productVM.calcTotalPrice()
            self.calcTotal.calcTotalPrice()
            self.calcTotal.calcTotalQuantity()
        }
        subItemQuantity = {
            if (Double((cell.quantity)!)!) == 1{}
            else{
                cell.quantity  = "\( Double((cell.quantity)!)!-1 )"
                self.qantityLabel.text = "\(cell.quantity ?? "0" )"
            }
            try? context.save()
            self.calcTotal.calcTotalPrice()
            self.calcTotal.calcTotalQuantity()
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        addItemQuantity?()
        updateTotalPriceInCart?()
    }
    
    @IBAction func minusButton(_ sender: Any) {
        subItemQuantity?()
        updateTotalPriceInCart?()
    }

}

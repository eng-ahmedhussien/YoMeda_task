//
//  CartVC.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 23/10/2022.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var searchBare: UISearchBar!
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var cartTotalPrice: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var languageButton: UIBarButtonItem!
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var productsLable: UILabel!
    @IBOutlet weak var deliveryfee: UILabel!
    @IBOutlet weak var variesByRegion: UILabel!
    @IBOutlet weak var productPricesmay: UILabel!
    
    var arrayOfProduct = [Cart]()
    var FilteredProduct = [Cart]()
    let productVM = ProductVM()
    let calcTotal = CalcTotal()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        searchBare.delegate = self
        setupChangeLanguageButton()
        setupLoclization()

    }
    override func viewWillAppear(_ animated: Bool) {
        do {
            arrayOfProduct = try context.fetch(Cart.fetchRequest())
            cartTable.reloadData()
        } catch let error {
            print(error)
        }
    }
    func setupTable(){
        cartTable.delegate=self
        cartTable.dataSource=self
        cartTable.rowHeight = 161
        
        do {
            arrayOfProduct = try context.fetch(Cart.fetchRequest())
            cartTable.reloadData()
            self.cartTotalPrice.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
            self.cartQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
        } catch let error {
            print(error)
        }
    }
    func setupChangeLanguageButton(){
        let AR = UIAction(title: "Arabic"){ _ in
            self.showAlertExit(title: "alert", message: "device need restart".localized)
            UserDefaults.standard.setValue(["ar"], forKey: "AppleLanguages")
        }
        let EN = UIAction(title: "English"){ _ in
            self.showAlertExit(title: "alert", message: "device need restart".localized)
            UserDefaults.standard.setValue(["en"], forKey: "AppleLanguages")
            
          }
        languageButton.menu = UIMenu(title: "", children: [AR,EN])

    }
    func setupLoclization(){
        title = "cart".localized
        checkoutButton.setTitle("do".localized, for: .normal)
        productsLable.text = "products X".localized
        deliveryfee.text = "delivery fee".localized
        variesByRegion.text = "varies by region".localized
        productPricesmay.text = "product pricesmay vary in different pharmacies".localized
    }
}
// MARK: - tabll
extension CartVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("arrayOfProduct form cart = \(arrayOfProduct.count)")
        return arrayOfProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? cartCell
        cell?.prepareCell(cell: arrayOfProduct[indexPath.row])
        cell?.updateTotalPriceInCart = {
            self.cartTotalPrice.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
            self.cartQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Delete(indexPath:indexPath)
        }
    }

    func Delete(indexPath:IndexPath){
        showConfirmAlert(title: "Are you sure?".localized, message:  "You will remove this item from the cart".localized) { [self] action in
            //remove form core data
            CoreDataManager.sharedInstance.delete(returnType: Cart.self, delete: arrayOfProduct[indexPath.row])
            //CoreDataManager.sharedInstance.Delete(cartItem: arrayOfProduct[indexPath.row])
            //remove form array
            arrayOfProduct.remove(at: indexPath.row)
            //remove from table
            cartTable.deleteRows(at: [indexPath], with: .left)
            self.cartTable.reloadData()
            //update cartTotalPrice cartQuantity lables
            self.cartTotalPrice.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
            self.cartQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
            //after delete update TotalPrice and TotalQuantity
            self.calcTotal.calcTotalPrice()
            self.calcTotal.calcTotalQuantity()
        }

    }

}
// MARK: -searchbar
extension CartVC:UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        FilteredProduct = []
        if searchText == ""{
            FilteredProduct = []
            arrayOfProduct = try! context.fetch(Cart.fetchRequest())
            cartTable.reloadData()
        }
        else{
            //arrayOfProduct = try context.fetch(Cart.fetchRequest())
            // FilteredProduct = []
            for i in arrayOfProduct{
                if ((i.name?.contains(searchText)) != nil){
                    FilteredProduct.append(i)
                }
                else{
                    
                }
            }
            arrayOfProduct = FilteredProduct
            print(arrayOfProduct.count)
            print(FilteredProduct.count)
            self.cartTable.reloadData()
        }

    }
    
   
}


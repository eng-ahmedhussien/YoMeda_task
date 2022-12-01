//
//  ViewController.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 21/10/2022.
//

import UIKit
import Combine

class SearchVC: UIViewController {

    @IBOutlet weak var searchBare: UISearchBar!
    @IBOutlet weak var productsTable: UITableView!{
        didSet{
            productsTable.delegate = self
            productsTable.dataSource = self
            productsTable.rowHeight = 161
           
        }
    }
    @IBOutlet weak var languageButton: UIBarButtonItem!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmbutton: UIButton!
    @IBOutlet weak var totalPriceInSearch: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    var arrayOfproducts = [Complaint]()
    let productVM = ProductVM()
    let calcTotal = CalcTotal()
    
    var observer : AnyCancellable?
    var observers : [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChangeLanguageButton()
        searchBare.delegate = self
        confirmView.isHidden = true
        calcTotal.calcTotalPrice()
        title = "search".localized
        confirmbutton.setTitle("confirmation".localized, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        productsTable.reloadData()
        totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
        productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
    }

    func setupChangeLanguageButton(){
        let AR = UIAction(title: "Arabic"){ _ in
            self.creatAlert(title: "alert".localized, message: "device need restart".localized)
            UserDefaults.standard.setValue(["ar"], forKey: "AppleLanguages")
        }
        let EN = UIAction(title: "English"){ _ in
            self.creatAlert(title: "alert".localized, message: "device need restart".localized)
            UserDefaults.standard.setValue(["en"], forKey: "AppleLanguages")
            
          }
        languageButton.menu = UIMenu(title: "", children: [AR,EN])
    }
    func creatAlert (title:String,message:String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok".localized, style: .default) { alert in
               exit(0)
          }
      
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        alert.addAction(cancelAction)
           alert.addAction(okButton)
           present(alert, animated: true, completion: nil)
       }
    @IBAction func gotoCartButton(_ sender: Any) {
        let toCart = storyboard?.instantiateViewController(identifier:"CartVC") as? CartVC
        navigationController?.pushViewController(toCart!, animated: true)
    }
    
}

// MARK: - tabll
extension SearchVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTable.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.prepareCell(cell: arrayOfproducts[indexPath.row])
        cell?.product = arrayOfproducts[indexPath.row]
        
        cell?.fristAddItemToCart = {
//            self.productVM.getSelectedItemFromCart(product: self.arrayOfproducts[indexPath.row]) { selectedItem, error in
//                if selectedItem != nil {
//                    selectedItem?.quantity  = "\(Double((selectedItem?.quantity)!)!)"
//                }
//                try? context.save()
//                self.productVM.calcTotalPrice()
//                self.totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
//                self.productVM.calcTotalQuantity()
//                self.productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
//            }
            CoreDataManager.sharedInstance.getSelectedItemFromCart(product: self.arrayOfproducts[indexPath.row]) { selectedItem, error in
                if selectedItem != nil {
                    selectedItem?.quantity  = "\(Double((selectedItem?.quantity)!)!)"
                }
                try? context.save()
                self.calcTotal.calcTotalPrice()
                self.totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
                self.calcTotal.calcTotalQuantity()
                self.productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
            }
            
            self.productsTable.reloadData()
        }
        
       cell!.addItemQuantity = {
            CoreDataManager.sharedInstance.getSelectedItemFromCart(product: self.arrayOfproducts[indexPath.row]) { selectedItem, error in
                if selectedItem != nil {
                    selectedItem?.quantity  = "\(Double((selectedItem?.quantity)!)!+1)"
                }
                try? context.save()
               // self.productVM.calcTotalPrice()
                self.calcTotal.calcTotalPrice()

                self.totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
                //self.productVM.calcTotalQuantity()
                self.calcTotal.calcTotalQuantity()
                self.productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
            }
//            self.productVM.getSelectedItemFromCart(product: self.arrayOfproducts[indexPath.row]) { selectedItem, error in
//                if selectedItem != nil {
//                    selectedItem?.quantity  = "\(Double((selectedItem?.quantity)!)!+1)"
//                }
//                try? context.save()
//                self.productVM.calcTotalPrice()
//                self.totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
//                self.productVM.calcTotalQuantity()
//                self.productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
//            }
            self.productsTable.reloadData()

        }

        cell!.subItemQuantity = {
            CoreDataManager.sharedInstance.getSelectedItemFromCart(product: self.arrayOfproducts[indexPath.row]) { selectedItem, error in
                if selectedItem != nil {
                    if (Double((selectedItem?.quantity)!)!) == 1{}
                    else{
                        selectedItem?.quantity  = "\( Double((selectedItem?.quantity)!)!-1 )"
                    }
                }
                try? context.save()
                self.calcTotal.calcTotalPrice()
                self.totalPriceInSearch.text = "\(UserDefaults.standard.double(forKey: "TotalPrice"))"
                self.calcTotal.calcTotalQuantity()
                self.productQuantity.text =  "\(UserDefaults.standard.double(forKey: "TotalQuantity"))"
            }
            self.productsTable.reloadData()
        }
        
        return cell!
    }

   
    
}
// MARK: -searchbar
extension SearchVC:UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.confirmView.isHidden = true
            arrayOfproducts = []
            DispatchQueue.main.async {
                self.productsTable.reloadData()
            }
        }
        else{
            let ProductViewModel = ProductVM()
//            ProductViewModel.fetchData(searchkey: searchText)
//            ProductViewModel.bindingData = { products , error in
//                if let products = products{
//                    self.arrayOfproducts = products
//                    self.confirmView.isHidden = CoreDataManager.sharedInstance.isCartEmpty() ? true:false
//                    self.productsTable.reloadData()
//                }
//                if let error = error {
//                    print(error)
//                }
//            }
            //combine
            ProductViewModel.fetchData(searchkey: searchText).receive(on: DispatchQueue.main).sink(receiveCompletion: { Completion in
                switch Completion{
                    case .finished:
                        print("finshed recive")
                    case .failure(let error):
                        print(error)
                }
            }, receiveValue: { value in
                self.arrayOfproducts = value
                self.confirmView.isHidden = CoreDataManager.sharedInstance.isCartEmpty() ? true:false
                self.productsTable.reloadData()
            }).store(in: &observers)
        }

    }
}


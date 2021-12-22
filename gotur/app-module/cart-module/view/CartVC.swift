//
//  CartVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit

final class CartVC: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomStyling: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var passingUsername:String?
    
    var cartArray = [SepetYemek]()
    
    var CartPresenter:ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        CartRouter.createModule(ref: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        CartPresenter?.getCart(username: passingUsername!)
        self.cartTableView.reloadData()
    }
    
    @IBAction func deleteAllButton(_ sender: Any) {
        CartPresenter?.wipeItems(object: cartArray)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        let packedData = (array:cartArray,total:totalPriceLabel.text!)
        performSegue(withIdentifier: "toCheckout", sender: packedData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCheckout"{
            let packedData = sender as! (array: [SepetYemek], total: String)
            let destinationVC = segue.destination as! CheckoutVC
            destinationVC.totalPrice = packedData.total
            destinationVC.objectListToDelete = packedData.array
        }
    }
    

}

extension CartVC:PresenterToViewCartProtocol{
    func setCart(cart: Array<SepetYemek>) {
        DispatchQueue.main.async { [weak self] in
            self?.cartArray = cart.reversed()
            self?.cartTableView.reloadData()
            
            
            if cart.count == 0 {
                _ = self?.navigationController?.popViewController(animated: true)
            }
            var total = 0
            for item in cart{
                let count = Int(item.yemek_siparis_adet!)!
                let price = Int(item.yemek_fiyat!)!
                let multiply = count * price
                total = total + multiply
                self?.updateLabelWithFade((self?.totalPriceLabel!)!, "₺\(total),00")
            }
            
        }
    }
    
    
}


//MARK: UITableView
extension CartVC:UITableViewDelegate,UITableViewDataSource, cartCellToViewProtocol{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedYemek = cartArray[indexPath.row]
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartCell
        cell.setCell(object: selectedYemek)
        
        cell.CartVC = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    
    func changeItemCount(stepper: Int, indexPath: IndexPath) {
        let selectedYemek = cartArray[indexPath.row]
        CartPresenter?.changeItemCount(count: stepper, object: selectedYemek)
    }
    func deleteSiparis(indexPath: IndexPath) {
        let selectedYemek = cartArray[indexPath.row]
        DispatchQueue.main.async{ [weak self] in
            self?.CartPresenter?.deleteItem(object: selectedYemek, addItemSwitch: false, count: 0)}
    }
}




//MARK: Styling
extension CartVC{
    func styling(){
        lessSmoothCorners(bottomStyling)
        
    }
    func lessSmoothCorners(_ view:UIView){
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
    }
    func updateLabelWithFade(_ label:UILabel, _ text:String){
        label.alpha = 0
        label.text = text
        UIView.animate(withDuration: 0.3){
        label.alpha = 1.0
        }
    }
    
}

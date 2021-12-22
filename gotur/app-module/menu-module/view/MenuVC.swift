//
//  MenuVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 10.12.2021.
//

import UIKit
import Kingfisher

final class MenuVC: UIViewController {
    
    var passingData:Array<Yemek>?
    var filteredYemekler:Array<Yemek>?
    var passingUsername:String?
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cartButton: UIButton!
    

    
    var MenuPresenter:ViewToPresenterMenuProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        filteredYemekler = passingData
        
        yemeklerTableView.dataSource = self
        yemeklerTableView.delegate = self
        searchBar.delegate = self
        
        MenuRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavBar(foregroundColor: UIColor(named: "goturYellow")!, font: UIFont(name: "Ubuntu-Bold", size: 30)!)
        MenuPresenter?.getCartTotal(username: passingUsername!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        customizeNavBar(foregroundColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }
    
    @IBAction func cartButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: passingUsername!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let packedData = sender as! (data:Yemek, name:String)
            let destinationVC = segue.destination as! DetailVC
            destinationVC.passingUsername = packedData.name
            destinationVC.selectedYemek = packedData.data
        }
        if segue.identifier == "toCart" {
            let username = sender as! String
            let destinationVC = segue.destination as! CartVC
            destinationVC.passingUsername = username
        }
    }

}
//MARK: PresenterToViewMenuProtocol
extension MenuVC:PresenterToViewMenuProtocol{
    func sendCartTotal(_ total: Int) {
        if total > 0 {
            cartButton.isHidden = false
            cartButton.setTitle("₺\(total),00", for: .normal)
        }else{
            cartButton.isHidden = true
        }
    }
}

//MARK: SearchBar
extension MenuVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredYemekler = passingData?.filter{ yemekler in
            if yemekler.yemek_adi!.lowercased().contains(searchText.lowercased()){
                return true
            }
            
            if searchText == ""{
                return true
            }
            
            return false
        }
        yemeklerTableView.reloadData()
    }
}

//MARK: Tableview
extension MenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredYemekler?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedYemek = filteredYemekler?[indexPath.row]
        let cell = yemeklerTableView.dequeueReusableCell(withIdentifier: "yemekCell", for: indexPath) as! yemekCell
        cell.setCell(selectedYemek!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let packedData = (data:filteredYemekler![indexPath.row], name:passingUsername!)
        performSegue(withIdentifier: "toDetail", sender: packedData)
        yemeklerTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


//MARK: Styling
extension MenuVC{
    func sharpCurvedViews(_ view:UIView){
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
    func customizeNavBar(foregroundColor:UIColor,font:UIFont){
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(named: "goturPurple")!
        appearence.titleTextAttributes = [.foregroundColor:foregroundColor, NSAttributedString.Key.font:font]
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
}

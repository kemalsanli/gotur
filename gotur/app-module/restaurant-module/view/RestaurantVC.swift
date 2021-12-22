//
//  RestaurantVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit

final class RestaurantVC: UIViewController {
    
    var passingData:Array<Yemek>?
    var passingUsername:String?
    var RestaurantPresenter:ViewToPresenterRestaurantProtocol?

    @IBOutlet weak var visualTableView: UITableView!
    @IBOutlet weak var midButtonImageView: UIImageView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling()
        
        visualTableView.delegate = self
        visualTableView.dataSource = self
        RestaurantRouter.createModule(ref: self)

    }
    override func viewWillAppear(_ animated: Bool) {
        customizeNavBar(foregroundColor: UIColor(named: "goturYellow")!, font: UIFont(name: "Ubuntu-Bold", size: 30)!)
        RestaurantPresenter?.getCartTotal(username: passingUsername!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        customizeNavBar(foregroundColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }
    @IBAction func cartButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: passingUsername!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenu"{
            let packedData = sender as! (data: Optional<Array<Yemek>>, name: Optional<String>)
            let destinationVC = segue.destination as! MenuVC
            destinationVC.passingData = packedData.data
            destinationVC.passingUsername = packedData.name
        }
        if segue.identifier == "toCart" {
            let username = sender as! String
            let destinationVC = segue.destination as! CartVC
            destinationVC.passingUsername = username
        }
    }
    

}


extension RestaurantVC:PresenterToViewRestaurantProtocol{
    func sendCartTotal(_ total: Int) {
        if total > 0 {
            cartButton.isHidden = false
            cartButton.setTitle("₺\(total),00", for: .normal)
        }else{
            cartButton.isHidden = true
        }
    }
    
    
}

extension RestaurantVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = visualTableView.dequeueReusableCell(withIdentifier: "restaurantCell")!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let packedData = (data:passingData, name:passingUsername)
        performSegue(withIdentifier: "toMenu", sender: packedData)
        visualTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension RestaurantVC{
    func styling(){
        sharpCurvedViews(addressView)
        circleButtons(midButtonImageView)
    }
    func sharpCurvedViews(_ view:UIView){
        view.layer.cornerRadius = 29
        view.layer.masksToBounds = true
    }
    func circleButtons (_ button: UIView){
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.masksToBounds = true
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


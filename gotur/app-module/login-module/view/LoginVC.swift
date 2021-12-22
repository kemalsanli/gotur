//
//  LoginVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit

final class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var LoginPresenter:ViewToPresenterLoginProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        LoginRouter.createModule(ref: self)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let _ = userNameTextField.text else { return }
        LoginPresenter?.getYemekler()
        activityIndicator.startAnimating()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRestaurant" {
            let yemekler = sender as? Array<Yemek>
            let navController = segue.destination as! UINavigationController
            let destinationVC = navController.topViewController as! RestaurantVC
            destinationVC.passingData = yemekler
            destinationVC.passingUsername = userNameTextField.text
        }
    }
    
}

extension LoginVC:PresenterToViewLoginProtocol{
    func vieweVeriGonder(_ Yemekler: Array<Yemek>) {
        activityIndicator.stopAnimating()
        performSegue(withIdentifier: "toRestaurant", sender: Yemekler)
    }
    
}

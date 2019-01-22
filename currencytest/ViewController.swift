//
//  ViewController.swift
//  currencytest
//
//  Created by Yash Nayak on 21/01/19.
//  Copyright © 2019 Yash Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var AUDLabel: UILabel!
    @IBOutlet weak var CNYLabel: UILabel!
    @IBOutlet weak var EURLabel: UILabel!
    @IBOutlet weak var INRLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func FETCHRATE(_ sender: Any) {
        getCurrency()
    }
    

    func getCurrency() {
        
        let url = URL(string: "http://ioshelp.tk/api/currency.json")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                if data != nil {
                    
                    do {
                        
                    let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jSONResult)
                            
                            let rates = jSONResult["rates"] as! [String : AnyObject]
                            
                            let Aud = String(describing: rates["AUD"]!)
                            self.AUDLabel.text = "AUD: \(Aud)"
                            
                            let Cny = String(describing: rates["CNY"]!)
                            self.CNYLabel.text = "CNY: \(Cny)"
                            
                            let Eur = String(describing: rates["EUR"]!)
                            self.EURLabel.text = "EUR: \(Eur)"
                            
                            let Inr = String(describing: rates["INR"]!)
                            self.INRLabel.text = "INR: \(Inr)"
                        }
                    } catch {
                        print("error featch data from url")
                    }
                    
                    
                    
                }
                
            }
            
        }
        task.resume()
    }
}


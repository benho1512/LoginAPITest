//
//  HomeViewController.swift
//  LoginAPITest
//
//  Created by Nguyen Duy anh on 2/25/20.
//  Copyright © 2020 Nguyen Duy anh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleHollowButton(logOutButton)
        view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.7803921569, blue: 0.9960784314, alpha: 1)
        
    }
   
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  ConfigurationViewController.swift
//  QuizGame
//
//  Created by Константин Надоненко on 23.03.2021.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        Game.shared.isRandom = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//
//  ViewController.swift
//  GSBasis
//
//  Created by gloomy.meng.049@gmail.com on 05/10/2019.
//  Copyright (c) 2019 gloomy.meng.049@gmail.com. All rights reserved.
//

import UIKit
import GSBasis




enum UserStatusNotifier: String, NotifierType {
    
    case login
    case logout
}

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        UserStatusNotifier.login.addObserver(self, object: nil) { (controller, notification) in
//            controller?.view
//        }
//    }
//}


//extension String: Compatible { }
//extension GS where Base == String {
//
//    func value() -> Double { return 2 }
//}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let c = Localize.availableLanguages();
        
        UserStatusNotifier.login.addObserver(self, object: nil) { (controller, _) in

        }
        
        UITableView.init().register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
//        let c = "2333".gs.value()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


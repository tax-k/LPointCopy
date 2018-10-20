//
//  PopViewController.swift
//  LPointCopy
//
//  Created by tax_k on 20/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

protocol mainControllerDelegate {
    func brightenssControl()
}

class PopViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupBottomConst: NSLayoutConstraint!
    
    var brightness: Float = Float(UIScreen.main.brightness)
    
    @IBAction func closePopViewAction(_ sender: Any) {
        
        dismiss(animated: false, completion: {
            self.mainDelegate?.brightenssControl()
        })
    }

    var mainDelegate:mainControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        popupView.backgroundColor = Colors.LPointBlue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

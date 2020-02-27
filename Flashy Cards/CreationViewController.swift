//
//  CreationViewController.swift
//  Flashy Cards
//
//  Created by Mira Mookerjee on 2/27/20.
//  Copyright © 2020 Mira Mookerjee. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

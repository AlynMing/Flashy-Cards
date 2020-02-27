//
//  CreationViewController.swift
//  Flashy Cards
//
//  Created by Mira Mookerjee on 2/27/20.
//  Copyright © 2020 Mira Mookerjee. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var answer: UITextField!
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = question.text
        let answerText = answer.text
    
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
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

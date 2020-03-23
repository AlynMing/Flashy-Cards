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
        question.text = initialQuestion
        answer.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var answer: UITextField!
    
    @IBOutlet weak var extraAnswer1: UITextField!
    @IBOutlet weak var extraAnswer2: UITextField!
    @IBOutlet weak var extraAnswer3: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = question.text
        let answerText = answer.text
        let extraText1 = extraAnswer1.text
        let extraText2 = extraAnswer2.text
        let extraText3 = extraAnswer3.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            //show error message
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated:true)
        }
        else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer1: extraText1!, extraAnswer2: extraText2!, extraAnswer3: extraText3!)
            flashcardsController.updateAfterFlashcardChange()
            dismiss(animated: true)
        }
    
       
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

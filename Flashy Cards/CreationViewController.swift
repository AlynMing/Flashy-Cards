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
        extraAnswer1.text = initialExtraAnswer1
        extraAnswer2.text = initialExtraAnswer2
        extraAnswer3.text = initialExtraAnswer3
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
    var initialExtraAnswer1: String?
    var initialExtraAnswer2: String?
    var initialExtraAnswer3: String?
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = question.text
        let answerText = answer.text
        let extraText1 = extraAnswer1.text
        let extraText2 = extraAnswer2.text
        let extraText3 = extraAnswer3.text
        if invalidInput(questionText: questionText, answerText: answerText, extraText1: extraText1, extraText2: extraText2, extraText3: extraText3) {
            let alert = UIAlertController(title: "Missing text", message: "All fields must be entered", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated:true)
        }
        else {
            // See if it's existing
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer1: extraText1!, extraAnswer2: extraText2!, extraAnswer3: extraText3!, isExisting: isExisting)
            flashcardsController.updateAfterFlashcardChange()
            dismiss(animated: true)
        }
    
       
    }
    
    func invalidInput(questionText: String?, answerText: String?, extraText1: String?, extraText2: String?, extraText3: String?) -> Bool {
        let answers = [questionText, answerText, extraText1, extraText2, extraText3]
        if Array(Set(answers)) != Array(answers) {
            //all elements not unique
            return false
        }
        for text in answers {
            if text == nil || text!.isEmpty {
                
                return true
            }
        }
        return false
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

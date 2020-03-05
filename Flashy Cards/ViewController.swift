//
//  ViewController.swift
//  Flashy Cards
//
//  Created by Mira Mookerjee on 2/15/20.
//  Copyright © 2020 Mira Mookerjee. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller contains only a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //set the flashcardsController property to self
        creationController.flashcardsController = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontLabel.isHidden = false
        backLabel.isHidden = true
        
        card!.clipsToBounds = false
        card!.layer.cornerRadius = 20.0
        card!.layer.shadowRadius = 15.0
        card!.layer.shadowOpacity = 0.2
        
        updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        for button in [button1, button2, button3, button4]  {
                button!.layer.borderWidth = 3.0
                button!.layer.borderColor = #colorLiteral(red: 0.6762284636, green: 1, blue: 0.8008129001, alpha: 1)
                button!.clipsToBounds = false
                button!.layer.cornerRadius = 20.0
        }
        
        for button in [plus, prevButton, nextButton] {
            button!.layer.borderWidth = 3.0
            if button == plus {
                button!.layer.borderColor = #colorLiteral(red: 0.581669569, green: 0.8673579097, blue: 0.6975092888, alpha: 1)
            }
            else {
                button!.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            button!.clipsToBounds = false
            button!.layer.cornerRadius = 20.0
        }

        for label in [frontLabel, backLabel] {
            label!.clipsToBounds = true
            label!.layer.cornerRadius = 20.0
        }

        
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
    }
    
    @IBAction func didTapOnCard(_ sender: Any) {
        for label in [frontLabel, backLabel] {
            label!.isHidden = (!label!.isHidden)
        }
    }
    
    func updateNextPrevButtons() {
        //Disable next button
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        //Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnButton1(_ sender: Any) {
        button1.isHidden = true
    }
    
    
    @IBAction func didTapOnButton2(_ sender: Any) {
        button2.isHidden = true
    }
    
    @IBAction func didTapOnButton3(_ sender: Any) {
        frontLabel.isHidden = true
        backLabel.isHidden = false
        button3.layer.borderColor = #colorLiteral(red: 0.8820998073, green: 0.6899847984, blue: 1, alpha: 1)
        
    }
    
    @IBAction func didTapOnButton4(_ sender: Any) {
        button4.isHidden = true
    }
}


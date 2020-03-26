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
    var extraAnswerOne: String
    var extraAnswerTwo: String
    var extraAnswerThree: String
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
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
    
    func getWrongAnswers(button1: UIButton, button2: UIButton, button3: UIButton, button4: UIButton ) -> Array<String> {
        let currentFlashcard = flashcards[currentIndex]
        var result = [String]()
        for button in [button1, button2, button3, button4] {
            let answer = button.titleLabel!.text
            if answer != currentFlashcard.answer {
                result.append(answer ?? "error")
            }
        }
        return result
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller contains only a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //set the flashcardsController property to self
        creationController.flashcardsController = self
        
        //edit
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            let wrongAnswers = getWrongAnswers(button1: button1, button2: button2, button3: button3, button4: button4)
            creationController.initialExtraAnswer1 = wrongAnswers[0]
            creationController.initialExtraAnswer2 = wrongAnswers[1]
            creationController.initialExtraAnswer3 = wrongAnswers[2]
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.isHidden = false
        backLabel.isHidden = true
        
        card!.clipsToBounds = false
        card!.layer.cornerRadius = 20.0
        card!.layer.shadowRadius = 15.0
        card!.layer.shadowOpacity = 0.2
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //Add our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", extraAnswer1: "Sao Paolo", extraAnswer2: "Washington D.C.", extraAnswer3: "Peru", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
            updateOptions()
        }
        for button in [button1, button2, button3, button4]  {
                button!.layer.borderWidth = 3.0
                button!.layer.borderColor = #colorLiteral(red: 0.6762284636, green: 1, blue: 0.8008129001, alpha: 1)
                button!.clipsToBounds = false
                button!.layer.cornerRadius = 20.0
        }

        for label in [frontLabel, backLabel] {
            label!.clipsToBounds = true
            label!.layer.cornerRadius = 20.0
        }

        
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Flashcard change
        animateCardOut(next: false)
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Flashcard change
        animateCardOut(next: true)

    }
    
    func updateAfterFlashcardChange() {
         // Update labels
         updateLabels()
         
         // Update buttons
         updateNextPrevButtons()
         
         // Update answer options
         updateOptions()
         
         // Update option borders
         for button in [button1, button2, button3, button4] {
             button?.isHidden = false
             button?.layer.borderColor = #colorLiteral(red: 0.6762284636, green: 1, blue: 0.8008129001, alpha: 1)
         }
         
         // Flip flashcard back
         frontLabel.isHidden = false
         backLabel.isHidden = true
    }
    
    @IBAction func didTapOnCard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            for label in [self.frontLabel, self.backLabel] {
                label!.isHidden = (!label!.isHidden)
            }
        })

    }
    
    func animateCardOut(next: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if (next) {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            }
            else {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            }
        }) { (finished) in
            // Update elements of screen that change when there is a new flashcard
            self.updateAfterFlashcardChange()
            
            // Run other animation
            self.animateCardIn(next: next)
        }
    }
    
    func animateCardIn(next: Bool) {
        // Start on the correct side (don't animate this)
        if (next) {
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }
        else {
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }
        
        //Animate card going back to its original position
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            // Know for sure we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne:  dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!, extraAnswerThree: dictionary["extraAnswerThree"]!)
            }
            
            //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        //From flashcards array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo, "extraAnswerThree": card.extraAnswerThree]
        }
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    func updateLabels() {
        // Get current flashcard
        print(currentIndex)
        let currentFlashcard = flashcards[currentIndex]
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer

    }
    
    func updateOptions() {
        let currentFlashcard = flashcards[currentIndex]
        
        //Create array of all answers
        var answers = [String]()
        answers.append(currentFlashcard.extraAnswerOne)
        answers.append(currentFlashcard.extraAnswerTwo)
        answers.append(currentFlashcard.extraAnswerThree)
        answers.append(currentFlashcard.answer)
        
        //Shuffle the array
        answers.shuffle()
        
        //Update answers
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
        
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
        
        updateOptions()
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswer1: String, extraAnswer2: String, extraAnswer3: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswer1, extraAnswerTwo: extraAnswer2, extraAnswerThree: extraAnswer3)
        
        if isExisting {
            //Replace existing flashcard
            print("current index is ", currentIndex)
            print("number of flashcards is", flashcards.count)
            flashcards[currentIndex] = flashcard
        }
        else {
            
            //Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            print("Added new flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        //Update buttons
        updateNextPrevButtons()
        
        //Update options
        updateOptions()
        
        //update labels
        updateLabels()
        
        //save flashcards to disk
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOnButton1(_ sender: Any) {
        updateButton(button: button1)
    }
    
    
    @IBAction func didTapOnButton2(_ sender: Any) {
        updateButton(button: button2)
    }
    
    @IBAction func didTapOnButton3(_ sender: Any) {
        updateButton(button: button3)
        
    }
    
    @IBAction func didTapOnButton4(_ sender: Any) {
        updateButton(button: button4)
    }
    
    func updateButton(button: UIButton) {
        let currentFlashcard = flashcards[currentIndex]
        if button.titleLabel!.text == currentFlashcard.answer {
             frontLabel.isHidden = true
             backLabel.isHidden = false
             button.layer.borderColor = #colorLiteral(red: 0.8820998073, green: 0.6899847984, blue: 1, alpha: 1)
         }
        else {
            button.isHidden = true
        }


    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        if flashcards.count == 1 {
            let alert = UIAlertController(title: "Cannot delete flashcard", message: "You cannot delete the last flashcard", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated:true)
        }
        else {
            // Show confirmation
            let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
            
            // Create delete and cancel actions
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard() }
            alert.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            // Present alert controller
            present(alert, animated: true)
        }
    }
    
    func deleteCurrentFlashcard() {
        // Delete current
        print("***BEFORE DELETION, current index is", currentIndex)
        if currentIndex == -1 {
            print("made it!")
        }
        else {
            flashcards.remove(at: currentIndex)
        }
        print("***AFTER DELETION, current index is", currentIndex)
        
        // Special cases:
        let greatestIndex = flashcards.count - 1
        // Check if the last flashcard was deleted
        if (currentIndex > greatestIndex) {
            currentIndex = greatestIndex
        }
        
        print("********current Index is:", currentIndex)
        // Update screen
        updateAfterFlashcardChange()
        
        // Update disk
        saveAllFlashcardsToDisk()
    }
    
}


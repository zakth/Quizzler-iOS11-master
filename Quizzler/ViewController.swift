//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
  
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumber = questionNumber + 1
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1);
        nextQuestion()
        
    }
    
    //Update UI to reflect score change, question number and progress bar
    func updateUI() {
      

        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) of 13"
        
        
    }
   //Update question text from allQuestions.list and perform updateUI function

    func nextQuestion() {
        
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            
            updateUI()
            
        }
        else {
         let Alert = UIAlertController(title: "Awesome", message: "You've reched the end of the quiz. Would you like to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            Alert.addAction(restartAction)
            
            present(Alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        
          let correctAnswer = allQuestions.list[questionNumber].answer
        
    
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score = score + 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
       
    }
    
    
    func startOver() {
       
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    

    
}


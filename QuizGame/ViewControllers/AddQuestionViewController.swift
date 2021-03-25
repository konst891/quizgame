//
//  AddQuestionViewController.swift
//  QuizGame
//
//  Created by Константин Надоненко on 25.03.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addQuestionButtonPressed(_ sender: Any) {
        
        if checkCorrectnessOfFields() {
            let questionText = questionTextField.text!
            let answers = [answer1TextField.text!, answer2TextField.text!, answer3TextField.text!, answer4TextField.text!].shuffled()
            let correctAnswer = answer1TextField.text!
            
            let question = Question(q: questionText, a: answers, correctAnswer: correctAnswer)
            Game.shared.customQuestions.append(question)
        }
        
    }
    
    func checkCorrectnessOfFields() -> Bool {
        
        if !questionTextField.hasText, !answer1TextField.hasText, !answer2TextField.hasText, !answer3TextField.hasText, !answer4TextField.hasText {
            let alert = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
        
    }
    
}

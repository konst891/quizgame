//
//  GameViewController.swift
//  QuizGame
//
//  Created by Константин Надоненко on 20.03.2021.
//

import UIKit

protocol GameViewControllerDelegate: class {
    func didEndGame(with result: Int)
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var questionNumber: UILabel!
    
    var quizLogic = QuizLogic(Game.shared.isRandom)
    weak var gameDelegate: GameDelegate?
    weak var gameVCDelegate: GameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDelegate?.setNumOfQuestions(quizLogic.quiz.count)
        quizLogic.gameDelegate = gameDelegate
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        quizLogic.questionNumb.addObserver(self, options: [.new, .initial], closure: { [weak self] (questionNumb, _) in
            self?.questionNumber.text = "Вопрос №\(String(questionNumb+1))"
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        quizLogic.questionNumb.removeObserver(self)
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let answer = sender.currentTitle!
        
        let isCorrect = quizLogic.checkAnswer(userAnswer: answer)
        
        if isCorrect {
            quizLogic.nextQuestion()
            gameDelegate?.updateScore()
            setupUI()
        } else {
            endGame()
        }
        
        if let game = gameDelegate {
            if game.didEndGame() {
                endGame()
            }
        }
        
    }
    
    func setupUI() {
        questionLabel.text = quizLogic.getQuestionText()
        
        let answerChoice = quizLogic.getQuestionAnswers()
        answerButton1.setTitle(answerChoice[0], for: .normal)
        answerButton2.setTitle(answerChoice[1], for: .normal)
        answerButton3.setTitle(answerChoice[2], for: .normal)
        answerButton4.setTitle(answerChoice[3], for: .normal)
    }
    
    func endGame() {
        let score = gameDelegate?.getScore()
        gameVCDelegate?.didEndGame(with: score!)
        self.dismiss(animated: true, completion: nil)
    }
}

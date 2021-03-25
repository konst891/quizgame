//
//  Game.swift
//  QuizGame
//
//  Created by Константин Надоненко on 20.03.2021.
//

import Foundation

class Game {
    
    private var gameSession: GameSession?
    
    var isRandom: Bool = false
    
    static var shared = Game()
    let dateFormatter = DateFormatter()
    
    var quizRecord = QuizStorage()
    
    var results: [Record] = [] {
        didSet {
            scoreStorage.saveScoreRecords(results)
        }
    }
    
    var customQuestions: [Question] = [] {
        didSet {
            quizRecord.saveCustomQuestions(customQuestions)
        }
    }
    
    var scoreStorage = ScoreStorage()
    
    private init() {
        results = scoreStorage.loadResults()
        dateFormatter.dateFormat = "MMM dd, yyyy HH MM"
    }
    
    func setupSession(session: GameSession) {
        gameSession = session
    }
    
    func getSession() -> GameSession {
        return gameSession!
    }
    
    func getCustomQuestions() -> [Question] {
        return quizRecord.loadQuestions()
    }
    
    func calculateResult() {
        if let game = gameSession {
            var result = Float(game.totalResult) / Float(game.numberOfQuestions)
            result *= 100.0
        
            let date = Date()
            let todaysDate = dateFormatter.string(from: date)
            let record = Record(date: todaysDate, score: result)
            results.append(record)
            gameSession = nil
        }
    }
    
}

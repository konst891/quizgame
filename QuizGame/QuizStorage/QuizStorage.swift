//
//  QuizStorage.swift
//  QuizGame
//
//  Created by Константин Надоненко on 25.03.2021.
//

import Foundation

class QuizStorage {
    
    private typealias Memento = Data
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "quiz"
    
    func saveCustomQuestions(_ records: [Question]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestions() -> [Question] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
}

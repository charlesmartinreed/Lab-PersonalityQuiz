//
//  QuestionData.swift
//  Lab-PersonalityQuiz
//
//  Created by Charles Martin Reed on 11/1/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

//MARK:- Question Model

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer] // each answer corresponds to a results type, dog answer is steak, cat answer is fish, etc.
}

// the types of questions that are possible in our quiz style app
enum ResponseType {
    case single, multiple, ranged
}

//MARK:- Answer Model
struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "😸", rabbit = "🐰", turtle = "🐢"
    
    // using a computed property to return the results of the quiz's findings
    var definition: String {
        switch self {
        case .dog:
            return "You are a dog."
        case .cat:
            return "You are a cat."
        case .rabbit:
            return "You are a rabbit."
        case .turtle:
            return "You are a turtle."
        }
    }
}

//MARK:- Default questions
var questions: [Question] = [
    Question(text: "Which food do you like the most?",
             type: .single,
             answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)]),
    Question(text: "Which activities do you enjoy?",
             type: .multiple,
             answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)]),
    Question(text: "How much do you enjoy car rides?",
             type: .ranged,
             answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
        ])
]

//
//  ResultsViewController.swift
//  Lab-PersonalityQuiz
//
//  Created by Charles Martin Reed on 10/31/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: Properties
    var responses: [Answer]!
    
    //MARK: @IBOutlets
    @IBOutlet weak var resultsAnswerLabel: UILabel!
    @IBOutlet weak var resultsDefinitionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()

        // Do any additional setup after loading the view.
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        // we only need the TYPE of the Answer, not the entire Answer strut
        let responseTypes = responses.map { $0.type }
        
        // iterate through the response types and calculate total
        for response in responseTypes {
            // key is response, value is either the previous value + 1 or 0
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        // sort the answers by frequency
        let frequentAnswersSorted = frequencyOfAnswers.sorted { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        }
        
        // a swiftier version of the above
        // let frequentAnswersSorted = frequencyOfAnswers.sorted {$0.1 > $1.1}.first!.key
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        // update your labels
        resultsAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultsDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    //MARK:- @IBActions
    

}

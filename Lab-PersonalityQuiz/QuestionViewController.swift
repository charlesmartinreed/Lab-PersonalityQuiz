//
//  QuestionViewController.swift
//  Lab-PersonalityQuiz
//
//  Created by Charles Martin Reed on 10/31/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //MARK:- Properties
    var questionIndex = 0 // keep track of how many questions have been answered
    var answersChosen: [Answer] = []
    
    //MARK:- @IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    //MARK:- @IBActions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        // when the user clicks a button, they've chosen an answer.
        // Pull it from the questions array and then append it to the answersChosen array.
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        //slider value is 0-1, value 0-.25 is first answer, value 0.75-1 is last answer
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    
    
    @IBAction func multipleAnswerButtonPressed() {
        // check which switches are enabled, use that to determine what answer to add to the answersChosen array
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    
    //MARK:- Methods
    func updateUI() {
        // called before displaying questions to the user - update title in nav bar as well as stack view visibility.
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        //update the buttons using setTitle
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        //return switches to default disabled state
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        // return slider to default when called
        rangedSlider.setValue(0.5, animated: false)
        
        //because there are only two labels to update but a variable amount of answers, we use first and last to access collection indices
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    //MARK:- Segue functions to ResultsVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as? ResultsViewController
            resultsViewController?.responses = answersChosen
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        // determine if there are any remaining questions, if so updateUI
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        
    }

}

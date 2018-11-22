//
//  QuestionViewController.swift
//  Personalityquiz
//
//  Created by Hugo Langeveld on 20/11/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func updateSingleStack(using answer: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answer: [Answer]) {
        multipleStackView.isHidden = false
        mulitSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answer[0].text
        multiLabel2.text = answer[1].text
        multiLabel3.text = answer[2].text
        multiLabel4.text = answer[3].text
    }
    
    func updateRangedStack(using answer: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answer.first?.text
        rangedLabel2.text = answer.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        }
        else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    var questions: [Question] = [
        Question(text: "What style do you have?",
                 type: .multiple,
                 answer: [
                    Answer(text: "Aggresive but stylefull", type: .roger ),
                    Answer(text: "autodidactic?", type: .agassi),
                    Answer(text: "Definitely my big serve", type: .sampras),
                    Answer(text: "I guess my topspin", type: .bjorn)
            ]),
        Question(text: "What is your best element in the game?",
                 type: .single,
                 answer: [
                    Answer(text: "Forehand", type: .roger),
                    Answer(text: "Serve", type: .sampras),
                    Answer(text: "Serve Volley", type: .bjorn),
                    Answer(text: "Chip and charge", type: .agassi)
            ]),
        Question(text: "How much are you in for the fame?",
                 type: .ranged,
                 answer: [
                    Answer(text: "Money, not fame", type: .agassi),
                    Answer(text: "Back in the eighties, moeny was more important than fame", type: .bjorn),
                    Answer(text: "I enjoy my titles, but also my swimming pool in LA, CA", type: .sampras),
                    Answer(text: "For me it's tennis", type: .roger)
            ])
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
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
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answer
        
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
    
    @IBOutlet weak var mulitSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answer
        if mulitSwitch1.isOn {
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
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answer
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
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
    
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}

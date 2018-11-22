//
//  ResultsViewController.swift
//  Personalityquiz
//
//  Created by Hugo Langeveld on 20/11/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityQuiz()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    var responses: [Answer]!

    func calculatePersonalityQuiz() {
        var frequencyOfAnswers: [Players: Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in return pair1.value > pair2.value })
        let mostCommonAnswer = frequentAnswersSorted.sorted { $0.1 > $1.1 }.first!.key
        resultAnswerlabel.text = "You are \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
    }
    
    @IBOutlet weak var resultAnswerlabel: UILabel!
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

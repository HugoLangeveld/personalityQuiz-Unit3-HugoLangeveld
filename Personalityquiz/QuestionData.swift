//
//  QuestionData.swift
//  Personalityquiz
//
//  Created by Hugo Langeveld on 21/11/2018.
//  Copyright © 2018 Hugo Langeveld. All rights reserved.
//

import Foundation

struct Question {
    var text : String
    var type: ResponseType
    var answer: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: Players
}

enum Players: String {
    
    case roger = "Roger!"; case sampras = "Sampras!"; case agassi = "Agassi!"; case bjorn = "Bjorn!"
    
    var definition: String {
        switch self {
        case .agassi:
            return "You're a kind of player that likes to be vulgar and aggresive on the court. "
        case .roger:
            return "Wow, what a technique. A dominating game you play, but with a lot of unforced errors. Did you consider an other entainement job?"
        case .sampras:
            return "Big serve and fast to net, you keep the game old-fashioned and short. Sure it is the best option?"
        case .bjorn:
            return "Classic. Best player of all time, unless the number of grand slams. Do you mind or is tennis not that important for you?"
        }
    }
}

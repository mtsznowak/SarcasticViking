//
//  Card.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import Foundation
class Card {

    var question: String
    var answer: String
    var nextDate: Date

    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.nextDate = Date()
    }

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormatter.string(from: self.nextDate)
        return "Card[q: " + question + ", a:" + answer + ", nextDate:" + dateString + "]";
    }

}

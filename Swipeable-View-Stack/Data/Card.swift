//
//  Card.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import Foundation
class Card {

    let MAX_STAGE = 5;
    var question: String
    var answer: String
    var nextDate: Date
    var currentInterval = 0.0;
    var stage = 0;

    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.nextDate = Date()
    }

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormatter.string(from: self.nextDate)
        return "Card[q: " + question + ", a:" + answer + ", currentInterval: " + String(self.currentInterval) + ", nextDate:" + dateString + "]";
    }

    func incProgress() {
        self.stage = self.stage + 1;
        self.currentInterval  = 3 * self.currentInterval;
        self.nextDate = Date() + self.currentInterval;
    }

    func resetProgress(totalTime: Double) {
        self.stage = 0
        self.currentInterval = totalTime / ((1-pow(Double(3), Double(MAX_STAGE)))/(-2));
    }


}

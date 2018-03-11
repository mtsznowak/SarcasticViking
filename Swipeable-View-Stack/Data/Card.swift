//
//  Card.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.

import Foundation
class Card {

    let MAX_STAGE = 5
    let question: String
    let answer: String
    let dataset: Dataset
    var nextDate: Date
    var currentInterval : Double?
    var stage = 0



    init(dataset: Dataset, question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.nextDate = Date()
        self.dataset = dataset
    }

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormatter.string(from: self.nextDate)
        return "Card[q: " + question + ", a:" + answer + ", nextDate:" + dateString + "]";
    }

    func incProgress() {
        guard let currentInterval = currentInterval else { return }
        self.stage = self.stage + 1;
        self.currentInterval  = 3 * currentInterval;
        self.nextDate = Date() + currentInterval;
    }

    func resetProgress() {
        guard let timeToExam = self.dataset.timeToExam() else { return }
        self.stage = 0
        self.currentInterval = timeToExam / ((1-pow(Double(3), Double(MAX_STAGE)))/(-2));
    }


}

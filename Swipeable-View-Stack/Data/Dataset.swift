//
//  Dataset.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import Foundation

class Dataset {
  var status = false
	var cards: [Card] = []
	var examDate: Date?

	init(cards: [Card]) {
		self.cards = cards
	}

	init(fileName: String) {
		var loadedCards : Array<Card> = [];
		if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
			do {
				let data = try String(contentsOfFile: path, encoding: .utf8)
				let allLines = data.components(separatedBy: .newlines)

				var question = "";
				for line in allLines {
					if line.characters.first == "Q" {
						// remove first 3 characters
						var new_question = line
						new_question.remove(at: new_question.startIndex)
						new_question.remove(at: new_question.startIndex)
						new_question.remove(at: new_question.startIndex)

						question = new_question;
					} else if line.characters.first == "A" {
						var answer = line;
						answer.remove(at: answer.startIndex)
						answer.remove(at: answer.startIndex)
						answer.remove(at: answer.startIndex)

						let card = Card(dataset: self, question: question, answer: answer)
						loadedCards.append(card)
					}
				}
			} catch {
				print(error)
			}
		}

		self.cards = loadedCards;
	}

	func changeStatus(newStatus: Bool, examDate: Date) {
		self.examDate = examDate
		self.status = newStatus;

		if newStatus == true {
			self.cards = self.cards.map {
				$0.resetProgress()
				return $0
			}
		}
	}

	// returns time to exam in seconds : Double
	func timeToExam() -> Double? {
		return self.examDate?.timeIntervalSinceNow;
	}

	func getCardsToQuiz() -> [Card] {
		var result : Array<Card> = []

		let currentDate  = Date()
		for card in self.cards {
			if card.nextDate <= currentDate {
				result.append(card);
			}
		}

		result.sort(by: { $0.nextDate.compare($1.nextDate) == .orderedAscending })

		return result;
	}

	func toString() -> String {
		var cardsString = ""
		for card in self.cards {
			cardsString += card.toString()
			cardsString += " "
		}
		return "status: " + String(self.status) + ", cards: " + cardsString
	}
}

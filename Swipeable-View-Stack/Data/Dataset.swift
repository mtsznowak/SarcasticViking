//
//  Dataset.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import Foundation

class Dataset {
	var cards: [Card]

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

						let card = Card(question: question, answer: answer)
						loadedCards.append(card)
					}
				}
			} catch {
				print(error)
			}
		}

		self.cards = loadedCards;
	}
}

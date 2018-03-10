import Foundation

class Session {
	var cards: [Card]
	private var correct = 0
  private var wrong = 0
	private var remaining : Int
	private var totalCards : Int

	init(dataset : Dataset) {
		self.cards = dataset.getCardsToQuiz()
		self.totalCards = self.cards.count
		self.remaining = self.cards.count
	}

	func registerCorrect() {
		guard let firstCard = self.cards.first else {return}
		firstCard.incProgress()
		self.cards.removeFirst()
		if correct + wrong < totalCards {
			correct = correct + 1
		}
		self.remaining = self.remaining - 1;
	}

	func registerWrong() {
		guard let firstCard = self.cards.first else {return}
		firstCard.resetProgress()
		self.cards.removeFirst()
		self.cards.append(firstCard)
		if correct + wrong < totalCards {
			wrong = wrong + 1
		}
	}

	func cardsRemaining() -> Int {
		return self.remaining
	}

	func getScore() -> Int {
		if correct + wrong > 0 {
				return Int(Double(correct) / Double(correct + wrong) * 100.0);
		}
		return 0;
	}





}


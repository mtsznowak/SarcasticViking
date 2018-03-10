import Foundation

class Session {
	var cards: [Card]
	private var correct = 0
  private var wrong = 0
	private var totalCards : Int

	init(dataset : Dataset) {
		self.cards = dataset.getCardsToQuiz()
		self.totalCards = self.cards.count
	}

	func registerCorrect() {
		guard let firstCard = self.cards.first else {return}
		firstCard.incProgress()
		self.cards.removeFirst()
		if correct + wrong < totalCards {
			correct = correct + 1
		}
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
		return self.totalCards - self.correct
	}

	func getScore() -> Int {
		if correct + wrong > 0 {
				return correct / (correct + wrong) * 100;
		}
		return 0;
	}





}


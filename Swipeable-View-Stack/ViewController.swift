//
//  ViewController.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.

import UIKit

class ViewController: UIViewController, SwipeableCardViewDataSource, VikingManagerDelegate, SwipeableCardViewDelegate {
    
    @IBOutlet weak var headerView: StaticShadowHeaderView!
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!

    @IBOutlet weak var vikingLabel: UILabel!
    
    var dataset: Dataset = Dataset(fileName: "data") {
        didSet {
            session = Session(dataset: dataset)
        }
    }
    var session: Session? = Session(dataset: Dataset(fileName: "data"))

    @IBAction func cyberwikingTouched(_ sender: Any) {
        VikingManager.sharedInstance.tellVikingSomethingHappened(event: .Touched)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeableCardView.dataSource = self
        swipeableCardView.delegate = self
        headerView.viewController = self
        VikingManager.sharedInstance.delegate = self
        swipeableCardView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        view.setNeedsLayout()
        setHeader()
        VikingManager.sharedInstance.tellVikingSomethingHappened(event: .Hello)
        
    }
    func setHeader() {
        guard let session = session else { return }
        headerView.cardsLeft = session.cardsRemaining()
        headerView.successPercentage = session.getScore()

    }
    func vikingFinishesSaying() {
        UIView.transition(with: self.vikingLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.vikingLabel.isHidden = true
            }, completion: nil)
    }
    func vikingSaysSomething(text: String) {
        UIView.transition(with: self.vikingLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.vikingLabel.isHidden = false
                            self?.vikingLabel.text = text
                            self?.vikingLabel.sizeToFit()
            }, completion: nil)
    }

    func swipedInDirection(direction: SwipeDirection?) {
        guard let direction = direction else {
            return
        }
        guard let session = session else {
            return
        }
        switch direction.horizontalPosition {
        case .left:
            
            session.registerWrong()
            VikingManager.sharedInstance.tellVikingSomethingHappened(event: .Fail)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.swipeableCardView.reloadData()
            }

            break
        case .right:
            session.registerCorrect()
        VikingManager.sharedInstance.tellVikingSomethingHappened(event: .Win)

            break
        default:
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.swipeableCardView.reloadData()
            }

            break
            
        }

        setHeader()
        if session.cardsRemaining() == 0 {
            VikingManager.sharedInstance.tellVikingSomethingHappened(event: .End)
        }
        
    }
    @IBAction func backToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func didSelect(card: SwipeableCardViewCard, atIndex index: Int) {
        
    }


}

// MARK: - SwipeableCardViewDataSource

extension ViewController {

    func numberOfCards() -> Int {
        guard let session = session else { return 0}
        return session.cards.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {

        let viewModel = session!.cards[index]
        let cardView = QuestionAnswerCardView()
        cardView.viewModel = viewModel
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }

}



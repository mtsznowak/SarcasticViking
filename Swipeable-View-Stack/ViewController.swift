//
//  ViewController.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwipeableCardViewDataSource, VikingManagerDelegate {
    @IBOutlet weak var headerView: StaticShadowHeaderView!
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!

    @IBOutlet weak var vikingLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeableCardView.dataSource = self
        headerView.viewController = self
        VikingManager.sharedInstance.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        view.setNeedsLayout()
        
        VikingManager.sharedInstance.tellVikingSomethingHappened(event: .Hello)
        
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


}

// MARK: - SwipeableCardViewDataSource

extension ViewController {

    func numberOfCards() -> Int {
        return viewModels.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = QuestionAnswerCardView()
        cardView.viewModel = viewModel
        return cardView        
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }

}

extension ViewController {

    var viewModels: [Card] {

        let hamburger = Card(question: "McDonalds", answer: "Hamburger")

        let panda = Card(question: "Panda", answer: "Animal")


        let puppy = Card(question: "Puppy", answer: "Pet")

        let poop = Card(question: "Poop", answer: "Smelly")

        let robot = Card(question: "Robot", answer: "Future")


        let clown = Card(question: "Clown", answer: "Scary")


        return [hamburger, panda, puppy, poop, robot, clown]
    }

}


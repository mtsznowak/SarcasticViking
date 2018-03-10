//
//  QuestionAnswerCardView.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import UIKit

class QuestionAnswerCardView: SwipeableCardViewCard, ShelfStateMangerDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var backgroundContainerView: UIView!
    @IBOutlet private weak var gestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBar: UIView!
    /// Shadow View
    private weak var shadowView: UIView?
    
    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0
    
    public static let barColor = UIColor.blue
    var viewModel: Card? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }
    
    func didSetShelfState(state: ShelfState) {
        if state == .Visible {
            gestureRecognizer.isEnabled = false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return shelfManager?.state == .Visible
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        shelfManager?.handlePanGesture(gesture: sender)
    }
    var shelfManager: ShelfStateManager?

    private func configure(forViewModel viewModel: Card?) {
        if viewModel != nil {
            
            backgroundContainerView.layer.cornerRadius = 14.0
            shelfManager = ShelfStateManager(limit: 100, constraint: heightConstraint, view: self.backgroundContainerView)
            shelfManager?.delegate = self
            setTopBarColor(color: QuestionAnswerCardView.barColor)
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureShadow()
    }
    
    // MARK: - Shadow
    
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: QuestionAnswerCardView.kInnerMargin,
                                              y: QuestionAnswerCardView.kInnerMargin,
                                              width: bounds.width - (2 * QuestionAnswerCardView.kInnerMargin),
                                              height: bounds.height - (2 * QuestionAnswerCardView.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
    func setTopBarColor(color: UIColor){
        topBar.backgroundColor = color
    }
}

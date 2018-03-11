//
//  ShelfStateManager.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import UIKit
enum ShelfState {
    case Hidden
    case Visible
    case Transitioning
}
protocol ShelfStateMangerDelegate {
    func didSetShelfState(state: ShelfState)
}
class ShelfStateManager: NSObject {
    var feedbackGenerator : UIImpactFeedbackGenerator? = nil
    
    var  verticalLimit: CGFloat
    var state: ShelfState {
        didSet {
            delegate?.didSetShelfState(state: state)
        }
    }
    weak var constraint: NSLayoutConstraint?
    weak var view: UIView?
    weak var disappearingView: UIView?
    public var delegate: ShelfStateMangerDelegate?
    
    func adjustAnimation(progress: CGFloat) {
        self.disappearingView?.alpha = progress
        
    }
    
    func presentShelf(){
        let animations = { () -> Void in
            self.constraint?.constant = 1
            self.view?.layoutIfNeeded()
        }
        let completion = {(value: Bool) -> Void in
            self.constraint?.constant = 0
        }

        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1000, options: UIViewAnimationOptions.allowUserInteraction, animations: animations, completion: completion)
    }
    
    
    func showShelf(){
        animateViewTo(value: vertialLimitAdjusted(), withOscilations: true,
                      completion: {(complteted: Bool) in
                        self.state = .Visible
        })
        adjustAnimation(progress: 1)
        self.state  = .Transitioning
    }
    func hideShelf(){
        animateViewTo(value: 0, withOscilations: false,
                      completion: {(complteted: Bool) in
                        self.state = .Hidden
        })
        adjustAnimation(progress: 0)
        self.state  = .Transitioning

    }
    
    init(limit: CGFloat, constraint: NSLayoutConstraint, view: UIView) {
        self.verticalLimit = limit
        self.constraint = constraint
        self.view = view
        self.state  = .Hidden
        constraint.constant = 0
    }
    private var totalTranslation : CGFloat = 0
    
    private func hasExceededVerticalLimit(constant: CGFloat) -> Bool{
        return constant > vertialLimitAdjusted()
    }
    private func vertialLimitAdjusted() -> CGFloat {
        let newSafeArea = UIEdgeInsets()
        return verticalLimit + newSafeArea.bottom
    }
    private func dampedPosition(yPosition : CGFloat) -> CGFloat {
        var x:CGFloat = 0
        if (yPosition <= 0){
            x = -0.2 * vertialLimitAdjusted() * log10(1-yPosition)
        } else if yPosition < vertialLimitAdjusted()  {
            x = yPosition
        }else {
            x = vertialLimitAdjusted() + vertialLimitAdjusted()*log10(1+(yPosition - vertialLimitAdjusted()) / vertialLimitAdjusted())
        }
        return x
        
    }
    private func animateViewTo(value: CGFloat, withOscilations oscilations:Bool = true, completion:  ((Bool)-> Void)? = nil) {
        guard let constraint = self.constraint else {
            return
        }
        constraint.constant = value
        let animations = { () -> Void in
            self.view?.layoutIfNeeded()
            self.totalTranslation = value
        }
        
        let duration:TimeInterval = 0.5
        if oscilations {
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: animations, completion: completion)
        }else {
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: animations, completion: completion)
        }
        
    }

    public func handlePanGesture(gesture: UIPanGestureRecognizer){
        guard let constraint = self.constraint else {
            return
        }

        let yTranslation = -gesture.translation(in: view).y
        totalTranslation = totalTranslation+yTranslation
        constraint.constant = dampedPosition(yPosition: totalTranslation)
        let percentage = min(1, max(0, totalTranslation/self.vertialLimitAdjusted()))
        switch gesture.state {
        case .began:
            
            // Instantiate a new generator.
            feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            
            // Prepare the generator when the gesture begins.
            feedbackGenerator?.prepare()
            
        case .ended:
            if (hasExceededVerticalLimit(constant: constraint.constant )){
                showShelf()
            }else if(gesture.velocity(in: view).y < 0) {
                showShelf()
            }else {
                hideShelf()
            }
            feedbackGenerator?.impactOccurred()
            feedbackGenerator = nil
        case .changed:
            self.state  = .Transitioning
            adjustAnimation(progress: percentage)
        case .cancelled, .failed:
            feedbackGenerator = nil
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: view)

    }
}

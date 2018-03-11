//
//  SampleSwipeableCard.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import UIKit
import CoreMotion

class SampleSwipeableCard: SwipeableCardViewCard {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var addButton: UIView!

    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!

    /// Shadow View
    private weak var shadowView: UIView?

    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0

    var viewModel: SampleSwipeableCellViewModel? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }
    
    func xibSetup() {
        super.xibSetup()
        
    }
    private func configure(forViewModel viewModel: SampleSwipeableCellViewModel?) {
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            imageBackgroundColorView.backgroundColor = viewModel.color
            imageView.image = viewModel.image

            backgroundContainerView.layer.cornerRadius = 14.0
            addButton.layer.cornerRadius = addButton.frame.size.height/4
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
        let shadowView = UIView(frame: CGRect(x: SampleSwipeableCard.kInnerMargin,
                                              y: SampleSwipeableCard.kInnerMargin,
                                              width: bounds.width - (2 * SampleSwipeableCard.kInnerMargin),
                                              height: bounds.height - (2 * SampleSwipeableCard.kInnerMargin)))
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

}

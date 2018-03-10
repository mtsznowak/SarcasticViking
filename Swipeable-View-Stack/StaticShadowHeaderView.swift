//
//  StaticShadowHeaderView.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit
import CoreMotion

class StaticShadowHeaderView: UIView, NibView {

    @IBOutlet private weak var backgroundContainerView: UIView!

    /// Shadow View
    private weak var shadowView: UIView?

    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()

        backgroundContainerView.layer.cornerRadius = 14.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()

        backgroundContainerView.layer.cornerRadius = 14.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureShadow()
    }

    // MARK: - Shadow

    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: StaticShadowHeaderView.kInnerMargin,
                                              y: StaticShadowHeaderView.kInnerMargin,
                                              width: bounds.width - (2 * StaticShadowHeaderView.kInnerMargin),
                                              height: bounds.height - (2 * StaticShadowHeaderView.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }

    @IBAction func abandon(_ sender: Any) {
        
    }
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 14.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }

}

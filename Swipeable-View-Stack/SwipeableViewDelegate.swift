//
//  SwipeableViewDelegate.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.

import Foundation

protocol SwipeableViewDelegate: class {

    func didTap(view: SwipeableView)

    func didBeginSwipe(onView view: SwipeableView)

    func didEndSwipe(onView view: SwipeableView)
    
    func didChangeSwipe(card: SwipeableView, direction: SwipeDirection?, percentage: Float)

}

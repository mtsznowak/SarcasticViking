//
//  SwipeableCardViewDelegate.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import Foundation

protocol SwipeableCardViewDelegate: class {
    func swipedInDirection(direction: SwipeDirection?)
    func didSelect(card: SwipeableCardViewCard, atIndex index: Int)
}

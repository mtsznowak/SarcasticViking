//
//  VikingManager.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Phill Farrugia. All rights reserved.
//

import UIKit

enum VikingEvents {
    case Hello
    case Fail
    case Win
    case End
    
}
protocol VikingManagerDelegate: NSObjectProtocol {
    func vikingSaysSomething(text: String)
    func vikingFinishesSaying()
}
class VikingManager: NSObject {
    public static var sharedInstance = VikingManager()
    weak var delegate: VikingManagerDelegate?
    
    
    private override init() {
        
    }
    func tellVikingSomethingHappened(event: VikingEvents) {
        switch event {
            case .Hello:
                sayText(text: "Witaj żałosny wojowniku. Jestem sarkastyczny cyberwiking Harold")
            break
            case .Fail:
            break
            case .Win:
            break
            case .End:
            break
        }
    }
    
    func sayText(text: String){
        
        let wordArray = text.split(separator: " ")
        for (index, _) in wordArray.enumerated() {
            let joined = wordArray.prefix(through: index).joined(separator: " ")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.4*Double(index)) {
                self.delegate?.vikingSaysSomething(text: joined)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.delegate?.vikingFinishesSaying()
        }
    }
    

}

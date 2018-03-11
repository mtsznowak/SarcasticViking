//
//  VikingManager.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import UIKit
import AVFoundation

enum VikingEvents {
    case Hello
    case Fail
    case Win
    case End
    case Touched
    
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
            sayText(text:  ["Typowe", "Nie spodziewałem się więcej", "Na brodę Odyna, ale jesteś głupi!", "I tak bym ci nie dał wiosłować", "Głupiec!", "Nic dziwnego że nic w życiu nie osiągnąłeś"].randomItem()!)
            break
        case .Win:
                sayText(text:  ["Wow!", "Nie ciesz się tak!", "Miałeś szczęście", "Ale osiągnięcie"].randomItem()!)
            break
        case .End:
            sayText(text:  [ "Jesteś tępy jak młot Thora!"].randomItem()!)
            break
        case .Touched:
            sayText(text:  ["Hej!", "Uważaj!", "Czego!", "Nie masz lepszych rzeczy do roboty?"].randomItem()!)
            break
        }
    }
    
    func sayText(text: String){
        
        let utterance = AVSpeechUtterance(string: text)
        
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Krzysztof-premium")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        
        let wordArray = text.split(separator: " ")
        for (index, _) in wordArray.enumerated() {
            let joined = wordArray.prefix(through: index).joined(separator: " ")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2*Double(index)) {
                self.delegate?.vikingSaysSomething(text: joined)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.delegate?.vikingFinishesSaying()
        }
    }
    

}

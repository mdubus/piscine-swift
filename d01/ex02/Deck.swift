import Foundation

class Deck: NSObject {
    static let allSpades:[Card] = Value.allValues.map {Card(color:Color.spade, value:$0)}
    static let allDiamonds:[Card] = Value.allValues.map {Card(color:Color.diamond, value:$0)}
    static let allHearts:[Card] = Value.allValues.map {Card(color:Color.heart, value:$0)}
    static let allClubs:[Card] = Value.allValues.map {Card(color:Color.club, value:$0)}
    
    static let allCards:[Card] = allSpades + allDiamonds + allHearts + allClubs
}

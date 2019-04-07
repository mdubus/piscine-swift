import Foundation

class Deck: NSObject {
    static let allSpades:[Card] = Value.allValues.map {Card(color:Color.spade, value:$0)}
    static let allDiamonds:[Card] = Value.allValues.map {Card(color:Color.diamond, value:$0)}
    static let allHearts:[Card] = Value.allValues.map {Card(color:Color.heart, value:$0)}
    static let allClubs:[Card] = Value.allValues.map {Card(color:Color.club, value:$0)}
    
    static let allCards:[Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func shuffle() {
        for (index, _) in self.enumerated() {
            let newIndex = Int(arc4random_uniform(UInt32(self.count - 1)))
            let tmp = self[index]
            self[index] = self[newIndex]
            self[newIndex] = tmp
        }
    }
}

import Foundation

class Deck: NSObject {
    static let allSpades:[Card] = Value.allValues.map {Card(color:Color.spade, value:$0)}
    static let allDiamonds:[Card] = Value.allValues.map {Card(color:Color.diamond, value:$0)}
    static let allHearts:[Card] = Value.allValues.map {Card(color:Color.heart, value:$0)}
    static let allClubs:[Card] = Value.allValues.map {Card(color:Color.club, value:$0)}
    
    static let allCards:[Card] = allSpades + allDiamonds + allHearts + allClubs
    
    var cards:[Card] = allCards
    var discards:[Card] = []
    var outs:[Card] = []
    
    init(sort:Bool) {
        if (sort == true) {
            cards.shuffle()
        }
    }
    
    override var description : String {
        var cardResult:String = ""
        for card in self.cards {
            cardResult += "\(card.color) \(card.value) \n"
        }
        return cardResult
    }
    
    func draw() -> Card? {
        if (cards.isEmpty == false) {
            let firstCard = cards.first
            outs.append(firstCard!)
            cards.removeFirst(1)
            return firstCard
        }
        return nil
    }
    
    func fold(c:Card) {
        if outs.contains(c) {
            discards.append(c)
            let index = outs.index(of: c)
            if (index != NSNotFound) {
                outs.remove(at: index!)
            }
        }
    }
    
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

import Foundation

class Card: NSObject {
    var color:Color
    var value:Value
    
    init (color:Color, value:Value) {
        self.color = color
        self.value = value
    }
    
    override var description : String {
        return "color : \(self.color), value : \(self.value)"
    }
    
    override func isEqual(to object: Any?) -> Bool {
        if let obj = object as? Card{
            return (obj.color == self.color && obj.value == self.value)
        }
        return false
    }
}

func == (c1: Card, c2 : Card) -> Bool {
    return (c1.color == c2.color && c1.value == c2.value)
}

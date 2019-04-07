func main () {
    let sortedDeck = Deck(sort:false)
    let shuffledDeck = Deck(sort:true)
    
    print("\n\u{001B}[0;36m********** Deck Description : sorted **********\n\u{001B}[0m")
    print(sortedDeck.description)
    
    print("\n\u{001B}[0;36m********** Deck Description : shuffled **********\n\u{001B}[0m")
    print(shuffledDeck.description)
    
    print("\n\u{001B}[0;35m********** Begin Values **********\n\u{001B}[0m")
    
    print("\n\u{001B}[0;36m********** Discards Cards **********\n\u{001B}[0m")
    print(shuffledDeck.discards)
    print("\n\u{001B}[0;36m********** Outs Cards **********\n\u{001B}[0m")
    print(shuffledDeck.outs)
    
    for _ in 0..<shuffledDeck.cards.count {
        shuffledDeck.draw()
    }
    
    print("\n\u{001B}[0;35m********** After drawing all cards **********\n\u{001B}[0m")
    
    print("\n\u{001B}[0;36m********** Discards Cards **********\n\u{001B}[0m")
    print(shuffledDeck.discards)
    print("\n\u{001B}[0;36m********** Outs Cards **********\n\u{001B}[0m")
    print(shuffledDeck.outs)
    
    for card in shuffledDeck.outs {
        shuffledDeck.fold(c:card)
    }
    
    print("\n\u{001B}[0;35m********** After folding all cards **********\n\u{001B}[0m")
    
    print("\n\u{001B}[0;36m********** Discards Cards **********\n\u{001B}[0m")
    print(shuffledDeck.discards)
    print("\n\u{001B}[0;36m********** Outs Cards **********\n\u{001B}[0m")
    print(shuffledDeck.outs)
}

main()



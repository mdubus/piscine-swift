func main () {    

    print("\n\u{001B}[0;36m********** All Cards **********\n\u{001B}[0m")
    var orderedDeck = Deck.allCards
    orderedDeck.shuffle()
    for allCards in orderedDeck {
        print (allCards)
    }
}

main()



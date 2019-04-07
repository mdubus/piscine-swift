func main () {    
    print("\n\u{001B}[0;36m********** All Spades **********\n\u{001B}[0m")
    for allSpades in Deck.allSpades {
        print (allSpades)
    }
    
    print("\n\u{001B}[0;36m********** All Diamonds **********\n\u{001B}[0m")
    for allDiamonds in Deck.allDiamonds {
        print (allDiamonds)
    }
    
    print("\n\u{001B}[0;36m********** All Hearts **********\n\u{001B}[0m")
    for allHearts in Deck.allHearts {
        print (allHearts)
    }
    
    print("\n\u{001B}[0;36m********** All Clubs **********\n\u{001B}[0m")
    for allClubs in Deck.allClubs {
        print (allClubs)
    }
    
    print("\n\u{001B}[0;36m********** All Cards **********\n\u{001B}[0m")
    for allCards in Deck.allCards {
        print (allCards)
    }
}

main()



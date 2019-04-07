func main () {
    
    print("\n\u{001B}[0;36m********** allColors **********\u{001B}[0m\n")
    let allColorTab = Color.allColors
    for eachColor in allColorTab {
        print ("name : \(eachColor), value : \(eachColor.rawValue)")
    }
    
    
    print("\n\u{001B}[0;36m********** allValues **********\n\u{001B}[0m")
    let allValuesTab = Value.allValues
    for eachValue in allValuesTab {
        print ("name : \(eachValue), value : \(eachValue.rawValue)")
    }
    
    print("\n\u{001B}[0;36m********** Card description **********\n\u{001B}[0m")
    let t2h = Card(color:Color.heart, value: Value.t2)
    let t2hbis = t2h
    let t3h = Card(color:Color.heart, value: Value.t3)
    print(t2h.description)
    print(t3h.description)
    
    print("\n\u{001B}[0;36m********** Card comparison **********\n\u{001B}[0m")
    
    print("is t2h equal to t2hbis (isEqual method) ? \(t2h.isEqual(t2hbis))")
    print("is t2h equal to t2hbis (== method) ? \(t2h == t2hbis)")
    
    print("is t2h equal to t3h (isEqual method) ? \(t2h.isEqual(t3h))")
    print("is t2h equal to t3h (== method) ? \(t2h == t3h)")
}

main()



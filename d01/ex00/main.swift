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
    
}

main()

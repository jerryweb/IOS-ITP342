//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var money  = 0.0
var person = ["bob": 22, "marry": 30]

person["john"] = 20
person["joel"] = 21
person["zerrohn"] = 14

person

func introduce (firstName: String, lastName: String) -> Void{

print("Hey \(firstName) \(lastName)")

}
introduce("Jerry", lastName: "Webb")

func divide(numerator : Double, denominator : Double){
    
}



let browser : String? = "Safari"

print("Welcome to \(browser)")
print("Welcome to \(browser)")
print("Welcome to \(browser)")
print("Welcome to \(browser)")

if let b =  browser{
    print("there is a browser and it's caled \(b)")
    
} else {
    print("There is no browser")
}


let closure = { (firstNum: Int, secondNum: Int) -> Int in
    
    return firstNum + secondNum

}

closure(20,30)


let add : (Int, Int) -> Int = { (firstNum: Int, secondNum: Int) -> Int in
    
    return firstNum + secondNum
    
}

add(20, 30)
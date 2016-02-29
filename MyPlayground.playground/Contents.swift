//: Playground - noun: a place where people can play

import UIKit

//string

var str = "Hello, playground"

var name:String = "Kevin" //define type with :, optional

print("Hello " + name + "!");

//integers
var int:Int = 9;


//double
var myDouble:Double = Double(int) * 2 / 1.3 + 12 - 4;

print("the value of myDouble is \(myDouble)");

//boolean
var isPretty:Bool = true;

//arrays

var myArray = [17,22,13,114];

print(myArray[0]);
print(myArray.count);
myArray.append(14);
myArray.removeAtIndex(3);

myArray.sort();

//Dictionaries

var myDictionary = ["computer":"something to play Call Of Duty on", "coffee":"a energy drink" ]

print(myDictionary["coffee"]!) //optional if not unwrapped

print(myDictionary.count);

myDictionary["pen"] = "Old fashioned writing impement"

myDictionary.removeValueForKey("computer")

print(myDictionary);


//for loop

for (var i = 0;i <= 10; i++){
  print(i);
}

//for in
//values are not mutable
var xMen:Array = ["Cyclops","Beast","Jean Grey","Iceman","Angel"];

for xman in xMen{
  print(xman);
}


//for in with enumerate
for(index,value ) in xMen.enumerate(){
  xMen[index] = value.uppercaseString
}

print(xMen[2]);


//while loop
var i = 1;
while(i <= 10) {
  print(i * 5);
  i++;
}


var arrOfNumbers = [5,6,2,7,1,9,6];

i = 0;

while i < arrOfNumbers.count{
  print(arrOfNumbers[i]);
  i++ //dont forget i++
}



//Prime numbers


func isItPrime (number:Int) -> Bool{
  if(number == 2){
    return true
  }
  //check if n is a multiple of 2
  if(number % 2 == 0 || number == 1){
    return false;
  }
  //if not, then just check the odds
  for(var i = 3; i*i <= number; i+=2){
    if(number % i == 0){
      return false;
    }
  }
  return true;
}




isItPrime(13)

var helloString = "Hello"
var newString = helloString + " Kevin"

for char in newString.characters{
  
  print(char)
}

var newTypeString = NSString(string: newString); //NSString is the native type

newTypeString.substringToIndex(5)
newTypeString.substringFromIndex(6)

newTypeString.substringWithRange(NSRange(location: 3, length: 5))

if newTypeString.containsString("Kevin"){
  //Kevin inside
}

newTypeString.componentsSeparatedByString(" ")
newTypeString.uppercaseString
newTypeString.lowercaseString














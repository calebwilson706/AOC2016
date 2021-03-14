//
//  Day9.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 12/03/2021.
//

import Foundation
class Day9 {
    var inputString : String
    
    init() {
        do {
            let filePath = "/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day9Input.txt"
            let contents = try String(contentsOfFile: filePath)
            inputString = contents
        } catch {
            inputString = ""
            print(error)
        }
    }
    func part1() {
        print(getTotalLengthDecoded(for: inputString))
    }
    func part2() {
        print(getLengthOfDecodedPart2(for: inputString))
    }
    private func getTotalLengthDecoded(for str : String) -> Int {
        var answer = 0
        var index = 0
        
        var indexOfLastOpenBracket = 0
        
        while (index < str.count) {
            //print(str[index])
            switch str[index] {
            case "x" :
                let nextRoundedCloser = getNextIndex(of: ")", starting: index, str: str)!
                
                let number1 = getIntegerFromStringRange(starting: indexOfLastOpenBracket + 1, ending: index - 1, str: str)
                
                let number2 = getIntegerFromStringRange(starting: index + 1, ending: nextRoundedCloser - 1, str: str)
                
                answer += number1!*number2!
                index = nextRoundedCloser + number1! + 1
            case "(":
                indexOfLastOpenBracket = index
                index += 1

            default:
                if Int(String(str[index])) == nil {
                    answer += 1
                }
                index += 1
            }
        }
            
        return answer
    }
    
    func decompressString(str : String) -> Int {
        var answer = ""
        var index = 0
        
        while index < str.count {
            if str[index] == "(" {
                var runningTotalString = ""
                var amountOfCharsString = ""
                index += 1
                
                while str[index] != "x" {
                    amountOfCharsString += String(str[index])
                    index += 1
                }
                
                index += 1
                var amountToRepeatStr = ""
                
                while str[index] != ")" {
                    amountToRepeatStr += String(str[index])
                    index += 1
                }
                
                //print(amountToRepeatStr)
                var totalMoved = 1
                //print(amountOfCharsString)
                //need to work out how many characters to move by!!
                index += 1
                while (totalMoved <= Int(amountOfCharsString)!) {
                    runningTotalString += String(str[index])
                    index += 1
                    totalMoved += 1
                }
                
                answer += String(repeating : runningTotalString, count: Int(amountToRepeatStr)!)
            } else {
                answer += String(str[index])
                index += 1
            }
        }
        
        return getLengthOfDecodedPart2(for: answer)
    }
    func getLengthOfDecodedPart2(for str : String) -> Int {
        var answer : Int = 0
        var index = 0
        var multiplesForEach : [Int : Int] = [:]
        
        
        while index < str.count {
            //print(index)
            if str[index] == "(" {
                var amountOfCharsString = ""
                index += 1
                
                while str[index] != "x" {
                    amountOfCharsString += String(str[index])
                    index += 1
                }
                
                index += 1
                
                var extraMultiple = ""
                while str[index] != ")" {
                    extraMultiple += String(str[index])
                    index += 1
                }
                
                index += 1
                
                var movedBy = 0
                while movedBy <  Int(amountOfCharsString)! {
                    multiplesForEach[index + movedBy] = (multiplesForEach[index + movedBy] ?? 1)*Int(extraMultiple)!
                    movedBy += 1
                    
                }
                
            } else {
                answer += multiplesForEach[index] ?? 1
                index += 1
            }
        }
        
        return (answer)
    }

}


func getNextIndex(of char : Character, starting : Int, str : String) -> Int? {
    var index = starting
    
    while index < str.count {
        if str[index] == char {
            return index
        }
        
        index += 1
    }
    
    return nil
}

func getIntegerFromStringRange(starting : Int, ending : Int, str : String) -> Int? {
    var workingString = ""
    var index = starting
    
    while index <= ending {
        let current = str[index]
        workingString += String(current)
        index += 1
    }
    
    return Int(workingString)
}


//97659 is too low

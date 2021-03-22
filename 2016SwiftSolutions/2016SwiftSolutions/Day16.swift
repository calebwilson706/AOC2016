//
//  Day16.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 22/03/2021.
//

import Foundation
import PuzzleBox

class Day16 {
    
    func part1() { solution(isPart1: true) }
    func part2() { solution(isPart1: false) }
    
    private func solution(isPart1 : Bool) {
        var currentAnswer : String? = nil
        
        func getPathsToEnd(currentPoint : Point, startingString : String) {
            //print(startingString)
            
            if !(0...3).contains(currentPoint.x) || !(0...3).contains(currentPoint.y) {
                return
            }
            
            if isPart1 {
                if startingString.count > currentAnswer?.count ?? 100 {
                    return
                }
            }
            
            if currentPoint == Point(x: 3, y: 0) {
                if startingString.count > currentAnswer?.count ?? 0 || isPart1 {
                    currentAnswer = startingString
                }
                return
            }
                
                
                
            let hashedString = MD5(string: startingString)
        
            if isDoorOpen(character: hashedString[0]) {
                getPathsToEnd(currentPoint: currentPoint.up(), startingString: startingString + "U")
            }
            if isDoorOpen(character: hashedString[1]) {
                getPathsToEnd(currentPoint: currentPoint.down(), startingString: startingString + "D")
            }
            if isDoorOpen(character: hashedString[2]) {
                getPathsToEnd(currentPoint: currentPoint.left(), startingString: startingString + "L")
            }
            if isDoorOpen(character: hashedString[3]) {
                getPathsToEnd(currentPoint: currentPoint.right(), startingString: startingString + "R")
            }
            
        }
        
        getPathsToEnd(currentPoint: Point(x: 0, y: 3), startingString: "pgflpeqp")
        let final = currentAnswer!.dropFirst(8)
        
        if isPart1 {
            print(final)
        } else {
            print(final.count)
        }
    }
    
   
    
    private func isDoorOpen(character : Character) -> Bool {
        return character != "a" && character.isLetter
    }
}

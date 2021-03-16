//
//  Day2.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 05/03/2021.
//

import Foundation
import PuzzleBox

private enum Movements {
    case U, R, D, L
}


class Day2 {
    
    let instructionText : String
    
    let mapOfPointsPart1 = [
        Point(x: 0, y: 0) : 7,
        Point(x: 0, y: 1) : 4,
        Point(x: 0, y: 2) : 1,
        Point(x: 1, y: 0) : 8,
        Point(x: 1, y: 1) : 5,
        Point(x: 1, y: 2) : 2,
        Point(x: 2, y: 0) : 9,
        Point(x: 2, y: 1) : 6,
        Point(x: 2, y: 2) : 3
    ]
    
    init() {
        do {
            let filePath = "/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day2Input.txt"
            let contents = try String(contentsOfFile: filePath)
            instructionText = contents
            print(instructionText)
        } catch {
            instructionText = ""
            print(error)
        }
    }
    
    func part1() {
        var currentPoint = Point(x: 1, y: 1)
        
        var answer = [Int]()
        
        instructionText.forEach { it in
            switch it {
            case "U":
                if currentPoint.y != 2 {
                    currentPoint = currentPoint.up()
                }
            case "D":
                if currentPoint.y != 0 {
                    currentPoint = currentPoint.down()
                }
            case "R":
                if currentPoint.x != 2 {
                    currentPoint = currentPoint.right()
                }
            case "L":
                if currentPoint.x != 0 {
                    currentPoint = currentPoint.left()
                }
            default:
                answer.append(mapOfPointsPart1[currentPoint]!)
            }
            
            print(currentPoint)
        }
        
        answer.append(mapOfPointsPart1[currentPoint]!)
        print(answer.reduce("", { acc, next in
            acc + "\(next)"
        }))
    }
    
    func part2() {
        let mapOfPointsPart2 : [Point : Character] = [
            //numbers
            
            Point(x: -2, y: 0) : "5",
            Point(x: -1, y: 0) : "6",
            Point(x: 0, y: 0) :  "7",
            Point(x: 1, y: 0) :  "8",
            Point(x: 2, y: 0) :  "9",
            Point(x: -1, y: 1) : "2",
            Point(x: 0, y: 1) :  "3",
            Point(x: 1, y: 1) :  "4",
            Point(x: 0, y: 2) :  "1",
            
            //letters
            
            Point(x: -1, y: -1) : "A",
            Point(x: 0, y: -1) : "B",
            Point(x: 1, y: -1) : "C",
            Point(x: 0, y: -2) : "D"
        ]
        
        var answer = [Character]()
        var currPoint = Point(x: -2, y: 0)
        
        instructionText.forEach { it in
            let tempNext : Point
            var isEnd = false
            
            switch it {
            case "U":
                tempNext = currPoint.up()
            case "D":
                tempNext = currPoint.down()
            case "L":
                tempNext = currPoint.left()
            case "R":
                tempNext = currPoint.right()
            default :
                tempNext = currPoint
                isEnd = true
            }
            
            if let keypadDigit = mapOfPointsPart2[tempNext] {
                if isEnd {
                    answer.append(keypadDigit)
                } else {
                    currPoint = tempNext
                }
            }
            
        }
        answer.append(mapOfPointsPart2[currPoint]!)
        print(String(answer))
    }
}

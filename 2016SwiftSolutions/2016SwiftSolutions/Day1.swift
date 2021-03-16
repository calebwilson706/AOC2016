//
//  Day1.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 04/03/2021.
//

import Foundation
import PuzzleBox


class PointDay1Part1 {
    var x : Int
    var y : Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class Day1 {
    var instructions : [String] = []
    
    init() {
        do {
            let filePath = "/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day1Input.txt"
            let contents = try String(contentsOfFile: filePath)
            self.instructions = contents.components(separatedBy: ", ")
        } catch {
            print(error)
        }
    }
    
    func part1() {
        let answer = PointDay1Part1(x: 0, y: 0)
        var direction = Directions.NORTH
        
        instructions.forEach { it in
    
            if it.first == "R" {
                direction = direction.turnRight()
            } else {
                direction = direction.turnLeft()
            }
            
            let num = Int(it.dropFirst())!
            
            
            switch direction {
            case .NORTH:
                answer.y += num
            case .EAST:
                answer.x += num
            case .SOUTH:
                answer.y -= num
            case .WEST:
                answer.x -= num
            }
            
        }
        
        print(abs(answer.x) + abs(answer.y))
    }
    
    func part2helper() -> Point {
        var current = Point(x: 0, y: 0)
        var direction = Directions.NORTH
        var visitedLocations : [Point : Bool] = [current : true]
        
        func checkIfMet(current : Point) -> Point? {
            if visitedLocations[current] == true {
                return current
            } else {
                visitedLocations[current] = true
                return nil
            }
        }
        
        for it in instructions {
            
            if it.first == "R" {
                direction = direction.turnRight()
            } else {
                direction = direction.turnLeft()
            }
            
            let num = Int(it.dropFirst())!
            print(num)
            
            switch direction {
            
            case .NORTH:
                
                for y in current.y + 1 ... current.y + num {
                    current = Point(x: current.x, y: y)
                    if let answer = checkIfMet(current: current) {
                        return answer
                    }
                    
                }
                
            case .EAST:
                for x in current.x + 1 ... current.x + num {
                    current = Point(x: x, y: current.y)
                    if let answer = checkIfMet(current: current) {
                        return answer
                    }
                }
            case .SOUTH:
                for y in (current.y - num ... current.y - 1).reversed() {
                    current = Point(x: current.x, y: y)
                    
                    if let answer = checkIfMet(current: current) {
                        return answer
                    }
                }
            case .WEST:
                for x in (current.x - num ... current.x - 1).reversed() {
                    current = Point(x: x, y: current.y)

                    if let answer = checkIfMet(current: current) {
                        return answer
                    }
                }
            }
            
            
        }
        
        return current
    }
    
    func part2() {
        let p = part2helper()
        
        print(abs(p.x) + abs(p.y))
    }
}

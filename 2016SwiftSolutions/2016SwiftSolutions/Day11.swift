//
//  Day11.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 17/03/2021.
//

import Foundation
import PuzzleBox

class Day11 {
    
    func solution(part : Int) {
        var floorCapacities = [
            1 : (part == 2) ? 8 : 4,
            2 : 2,
            3 : 4,
            4 : 0
        ]
        
        var moves = 0
        
        for floor in 1...3 {
            while floorCapacities[floor] != 0 {
                floorCapacities[floor]! -= 2
                floorCapacities[floor + 1]! += 2
                moves += 1
                
                if floorCapacities[floor] != 0 {
                    floorCapacities[floor]! += 1
                    floorCapacities[floor + 1]! -= 1
                    moves += 1
                }
            }
        }
        
        print(moves)
        
        
    }
    
    func part1() {
        solution(part: 1)
    }
    func part2() {
        solution(part: 2)
    }
}

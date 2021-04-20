//
//  Day25.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 20/04/2021.
//

import Foundation

class Day25 : Day12 {
    
    init() {
        super.init(filePath: "/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day25Input.txt")
    }
    
    override func part1() {
        for num in 0...100000 {
            if let answer = solution(aStart: num, cStart: 0) {
                print(answer)
                return
            }
            //print("**\(num)")
        }
    }
}

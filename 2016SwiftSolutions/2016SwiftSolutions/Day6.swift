//
//  Day3.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 07/03/2021.
//

import Foundation


class Day6 {
    var inputs = [String]()
    
    
    init() {
        do {
            let filePath = "/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day6Input.txt"
            let contents = try String(contentsOfFile: filePath)
            self.inputs = contents.components(separatedBy: "\n")
        } catch {
            print(error)
        }
    }
    
    func bothPartsSolution(operation : (Int) -> Character) {
        var answer = ""
        
        (0 ..< 8).forEach { it in
            answer += String(operation(it))
        }
        
        print(answer)
    }
    
    func part1() {
        bothPartsSolution(operation: { num in
            getFrequencyMap(n: num).max(by: { $0.value < $1.value })!.key
        })
    }
    
    func part2() {
        bothPartsSolution(operation: { num in
            getFrequencyMap(n: num).min(by: { $0.value < $1.value })!.key
        })
    }
    
    func getFrequencyMap(n : Int) -> [Character : Int] {
        var counts : [Character : Int] = [:]
        
        inputs.forEach { it in
            let letter = it[n]
            counts[letter] = (counts[letter] ?? 0) + 1
        }
        
        return counts
    }
}

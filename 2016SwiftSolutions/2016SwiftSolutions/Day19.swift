//
//  Day19.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 24/03/2021.
//

import Foundation
import PuzzleBox


class Day19 {
    let listOfElvesLength = 3014387
    
    func part1() {
        var currentAmountOfPresentsForElf : [Int : Int] = [:]
        
        var currentElf = 1
        
        while true {
            //print(currentAmountOfPresentsForElf)
            let currentElfPresents = currentAmountOfPresentsForElf[currentElf] ?? 1
            
            if currentElfPresents == listOfElvesLength {
                break
            }
            
            let nextElfIndex = getNextElfPart1(current: currentElf, max: listOfElvesLength, map: currentAmountOfPresentsForElf)
            
            if currentElfPresents == 0 {
                currentElf = nextElfIndex
                continue
            }
            
            currentAmountOfPresentsForElf[currentElf] = currentElfPresents + (currentAmountOfPresentsForElf[nextElfIndex] ?? 1)
            currentAmountOfPresentsForElf[nextElfIndex] = 0
            currentElf = nextElfIndex
        }
        
        print(currentElf)
    }
    
    
    func part2() {
        var i = 3
        
        while i*3 < listOfElvesLength {
            i *= 3
        }
        
        print(listOfElvesLength - i)
    }
    
    func part2ShowPattern(amountOfElves : Int){
        let elvesStarting = (1...amountOfElves).map { $0 }
        let elves = LinkedList(from: elvesStarting)
        
        while elves.size > 1 {
            
            var currentElfIndex = 0
            
            while (currentElfIndex < elves.size) {
                let next = (currentElfIndex + (elves.size / 2)) % elves.size
                elves.remove(at: next)
                if next > currentElfIndex {
                    currentElfIndex += 1
                }
                
            }
            
            
        }
        
        elves.printMyList()
    }
    private func getNextElfPart1(current : Int, max : Int, map : [Int : Int]) -> Int {
        let nextElfActual = current + 1
        
        var current =  (nextElfActual <= max) ? nextElfActual : 1

        while true {
            if map[current] != 0 {
                return current
            } else {
                current += 1
                if current > max {
                    current = 1
                }
            }
        }
    }
    
}

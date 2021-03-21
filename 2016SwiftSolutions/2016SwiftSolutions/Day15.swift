//
//  Day15.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 21/03/2021.
//

import Foundation

//Disc #1 has 13 positions; at time=0, it is at position 1.
//Disc #2 has 19 positions; at time=0, it is at position 10.
//Disc #3 has 3 positions; at time=0, it is at position 2.
//Disc #4 has 7 positions; at time=0, it is at position 1.
//Disc #5 has 5 positions; at time=0, it is at position 3.
//Disc #6 has 17 positions; at time=0, it is at position 5.

struct Disc {
    let maxPosition : Int
    let startPosition : Int
    
   
    func getNewPosition(startTime : Int, discNumber : Int) -> Int {
        let newPosition = startPosition + discNumber + startTime
        return ((newPosition > maxPosition) ? (newPosition % maxPosition) : newPosition)
    }
}


class Day15 {
    func part1() {
        solution(discs: [
            1 : Disc(maxPosition: 13, startPosition: 1),
            2 : Disc(maxPosition: 19, startPosition: 10),
            3 : Disc(maxPosition: 3, startPosition: 2),
            4 : Disc(maxPosition: 7, startPosition: 1),
            5 : Disc(maxPosition: 5, startPosition: 3),
            6 : Disc(maxPosition: 17, startPosition: 5)
        ])
    }
    func part2() {
        solution(discs: [
            1 : Disc(maxPosition: 13, startPosition: 1),
            2 : Disc(maxPosition: 19, startPosition: 10),
            3 : Disc(maxPosition: 3, startPosition: 2),
            4 : Disc(maxPosition: 7, startPosition: 1),
            5 : Disc(maxPosition: 5, startPosition: 3),
            6 : Disc(maxPosition: 17, startPosition: 5),
            7 : Disc(maxPosition: 11, startPosition: 0)
        ])
    }
    
    func solution(discs : [Int : Disc]) {
        var time = 0
        
        while (true) {
            var foundValidSet = true
            var previousPosition : Int? = nil
            for discNumber in 1...discs.count {
                let discPosition = discs[discNumber]!.getNewPosition(startTime: time, discNumber: discNumber)
                
                foundValidSet = (discPosition == previousPosition ?? discPosition) && foundValidSet
                previousPosition = discPosition

            }
            
            if foundValidSet {
                break
            }
            
            time += 1
        }

        print(time)
    }
    
}

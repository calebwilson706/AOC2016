//
//  Day24.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 18/04/2021.
//

import Foundation
import PuzzleBox

//get connections
class Day24ConnectionFinder : PuzzleClass {
    
    var myImportantPoints : [Int : Point] {
        return [
            0 : getCoord(of: "0"),
            1 : getCoord(of: "1"),
            2 : getCoord(of: "2"),
            3 : getCoord(of: "3"),
            4 : getCoord(of: "4"),
            5 : getCoord(of: "5"),
            6 : getCoord(of: "6"),
            7 : getCoord(of: "7")
        ]
    }
    
    var myMap : [[Character]] {
        getGridOfPoints()
    }
    
    func displayConnections() {
        for lowerNum in 0...6 {
            for next in (lowerNum + 1)...7 {
                let start = myImportantPoints[lowerNum]!
                let end = myImportantPoints[next]!
                
                print("\(lowerNum)->\(next) : \(findShortestDistance(from: start, to: end, map: myMap))")
            }
        }
    }
    
    func getCoord(of num: Character) -> Point {
        let map = getGridOfPoints()
        let yCoord = map.firstIndex { $0.contains(num) }!
        let yLine = map[yCoord]
        let xCoord = yLine.firstIndex(of : num)!
        
        return Point(x: xCoord, y: yCoord)
    }
    
    func getGridOfPoints() -> [[Character]] {
        var results = [[Character]]()
        
        inputStringUnparsed?.components(separatedBy: "\n").forEach { line in
            results.append([Character](line))
        }
        
        return results
    }
    
    func findShortestDistance(from origin : Point, to end : Point, map : [[Character]]) -> Int {
        var currentShortest = 2000
        var visitedNodes = [Point : Int]()
        
        func getPath(currentPoint : Point,currentTotal : Int) {
            if visitedNodes[currentPoint] ?? 2000 <= currentTotal {
                return
            } else {
                visitedNodes[currentPoint] = currentTotal
            }
                
            //print(currentShortest)
            if currentTotal >= currentShortest {
                return
            }
            
            if currentPoint == end {
                currentShortest = currentTotal
                return
            }
            
            if let above = getNextPoint(direction: .SOUTH, currentPoint: currentPoint, map: map) {
                getPath(currentPoint: above, currentTotal: currentTotal + 1)
            }
            if let right = getNextPoint(direction: .EAST, currentPoint: currentPoint, map: map) {
                getPath(currentPoint: right, currentTotal: currentTotal + 1)
            }
            if let left = getNextPoint(direction: .WEST, currentPoint: currentPoint, map: map) {
                getPath(currentPoint: left, currentTotal: currentTotal + 1)
            }
            if let below = getNextPoint(direction: .NORTH, currentPoint: currentPoint, map: map) {
                getPath(currentPoint: below, currentTotal: currentTotal + 1)
            }
            
            
            
        }
        
        getPath(currentPoint: origin, currentTotal: 0)
        return currentShortest
    }
    
    func getNextPoint(direction : Directions, currentPoint : Point, map : [[Character]]) -> Point? {
        var newPoint = currentPoint
        switch direction {
        case .NORTH:
            newPoint = currentPoint.up()
        case .EAST:
            newPoint = currentPoint.right()
        case .SOUTH:
            newPoint = currentPoint.down()
        case .WEST:
            newPoint = currentPoint.left()
        }
        
        return ((map[newPoint.y][newPoint.x] == "#") ? nil : newPoint )
    }
    
    
}

struct Connection {
    let a : Int
    let b : Int
    let distance : Int
    
    init(unparsedString : String) {
        let items = unparsedString.split(separator: " ")
        self.a = Int(items[0])!
        self.b = Int(items[1])!
        self.distance = Int(items[2])!
    }
    
}

struct Path {
    let destination : Int
    let distance : Int
}

func getConnectionsDay24() -> [Int : [Path]]{
    var results : [Int : [Path]] = [
        0 : [],
        1 : [],
        2 : [],
        3 : [],
        4 : [],
        5 : [],
        6 : [],
        7 : []
    ]
    let filepath = "/Users/calebjw/Documents/Developer/AdventOfCode/2016/2016SwiftSolutions/2016SwiftSolutions/Day24/Day24FoundPaths.txt"
    let content = try? String(contentsOfFile: filepath).components(separatedBy: "\n").dropLast()
    content?.forEach { line in
        let connection = Connection(unparsedString: line)
        
        results[connection.a]!.append(Path(destination: connection.b, distance: connection.distance))
        results[connection.b]!.append(Path(destination: connection.a, distance: connection.distance))
    }
        
        
    return results
}

class Day24 {
    let connections = getConnectionsDay24()
    
    func part1() {
        solution(part: 1)
    }
    func part2() {
        solution(part: 2)
    }
    private func solution(part : Int) {
        let allItems = [1,2,3,4,5,6,7]
        var answer = 5000

        for _ in 0...40000 {
            let tempList = [0] + allItems.shuffled()
            answer = min(answer, findTotalDistance(orderedList: tempList, part: part))
        }
        
        print(answer)
    }
    
    private func findTotalDistance(orderedList : [Int], part : Int) -> Int {
        var itemsToVisit = orderedList
        
        if part == 2 {
            itemsToVisit.append(0)
        }
        var total = 0
        var index = 0
        
        while index < itemsToVisit.count - 1 {
            total += connections[itemsToVisit[index]]!.first { $0.destination == itemsToVisit[index + 1] }!.distance
            index += 1
        }
        
        return total
    }
}

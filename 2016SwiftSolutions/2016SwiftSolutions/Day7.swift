//
//  Day7.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 08/03/2021.
//

import Foundation
import PuzzleBox

struct IPasComponents {
    let largerStrings : [String]
    let enclosedStrings : [String]
}


private func getStringComponentsFromAddress(item : String) -> IPasComponents {
    let firstRegex = try! NSRegularExpression(pattern: "[a-z]+")
    let components = parseMatchesToStringArray(regexStatement: firstRegex, item)
    
    let squareRegex = try! NSRegularExpression(pattern: "\\[[a-z]+\\]")
    let squareComponents = parseMatchesToStringArray(regexStatement: squareRegex, item).map({
        String(
            $0.dropFirst()
                .dropLast()
        )
    })
    
    let largeStringParts = components.filter { !squareComponents.contains($0) }
    
    return IPasComponents(largerStrings: largeStringParts, enclosedStrings: squareComponents)
}



func parseMatchesToStringArray(regexStatement : NSRegularExpression, _ str : String) -> [String] {
    let rangeOfString = NSRange(location: 0, length: str.utf16.count)
    return (regexStatement.matches(in: str, range: rangeOfString).map {
        String(str[Range($0.range, in: str)!])
    })
}


class Day7 {
    var components = [IPasComponents]()
    
    init() {
        do {
            let filePath = "/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day7Input.txt"
            let contents = try String(contentsOfFile: filePath)
            let lines = contents.components(separatedBy: "\n")
            
            components = lines.map { getStringComponentsFromAddress(item: $0)}
            //print(components)
        } catch {
            print(error)
        }
    }
    
    private func bothPartsSolution( operation : (IPasComponents) -> Bool ) {
        print(components.reduce(0, { acc, next in
            acc + (operation(next) ? 1 : 0)
        }))
    }
    func  part1() {
        bothPartsSolution(operation: supportsISL)
    }
    
    func  part2() {
        bothPartsSolution(operation: supportsSSL)
    }
    
    private func supportsISL(_ item : IPasComponents) -> Bool {
        if !(item.enclosedStrings.contains { $0.checkForAbba() }) {
            return item.largerStrings.contains {$0.checkForAbba()}
        } else {
            return false
        }
    }

    private func supportsSSL(_ item : IPasComponents) -> Bool {
        var allBabs = [String]()
        
        item.largerStrings.forEach { supernet in
            allBabs += supernet.checkForAba()
        }
        
        return item.enclosedStrings.contains { containsOneOf(strings: allBabs, in: $0) }
        
    }


    private func containsOneOf(strings : [String], in hypernet : String) -> Bool {
        for item in strings {
            if hypernet.contains(item) {
                return true
            }
        }
        
        return false
    }
}




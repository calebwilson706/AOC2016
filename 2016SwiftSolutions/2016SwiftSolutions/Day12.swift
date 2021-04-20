//
//  Day12.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 17/03/2021.
//

import Foundation
import PuzzleBox

enum InstructionsDay12And25 {
    case cpy, inc, dec, jnz, out
}

struct Day12Instruction {
    let instruction : InstructionsDay12And25
    let firstValue : String
    var secondValue : String?
    
    mutating func giveSecondNumber(this value : String){
        self.secondValue = value
    }
}

func getCorrectInstructionFromStringDay12(str : String?) -> InstructionsDay12And25 {
    switch str {
    case "cpy":
        return .cpy
    case "inc":
        return .inc
    case "dec":
        return .dec
    case "out":
        return .out
    default :
        return .jnz
    }
}

class Day12 : PuzzleClass {
    
    func getInstructions() -> [Day12Instruction] {
        var allInstructions = [Day12Instruction]()
        
        inputStringUnparsed!.components(separatedBy: "\n").forEach {
            let components = $0.components(separatedBy: " ")
            let instruction = getCorrectInstructionFromStringDay12(str: components.first)
            var newInstructionItem = Day12Instruction(instruction: instruction, firstValue: components[1], secondValue: nil)
            
            if instruction != .dec && instruction != .inc && instruction != .out {
                newInstructionItem.giveSecondNumber(this: components.last!)
            }
            
            allInstructions.append(newInstructionItem)
        }
        
        return allInstructions
    }
    
    func solution(aStart : Int, cStart : Int) -> Int? {
        let instructions = getInstructions()
        
        var registers = [
            "a" : aStart,
            "b" : 0,
            "c" : cStart,
            "d" : 0
        ]
        
        var index = 0
        var outputString = ""
        
        while (index < instructions.count) {
            let item = instructions[index]
            switch item.instruction {
            
            case .cpy:
                let valueBeingInserted = Int(item.firstValue) ?? registers[item.firstValue]!
                registers[item.secondValue!] = valueBeingInserted
            case .inc:
                registers[item.firstValue]! += 1
            case .dec:
                registers[item.firstValue]! -= 1
            case .jnz:
                let checkShouldMove = Int(item.firstValue) ?? registers[item.firstValue]!
                index += ((checkShouldMove == 0) ? 1 : Int(item.secondValue!) ?? registers[item.secondValue!]!) - 1
            case .out:
                outputString += "\(registers[item.firstValue] ?? -1)"
            
                if outputString.count > 9 {
                    print(outputString)
                    if outputString == "0101010101" {
                        return(aStart)
                    }
                    return nil
                }
            }
            
            index += 1
            
        }
        
        print(registers)
        return nil
    }
    
    func part1() {
        let _ = solution(aStart: 0, cStart: 0)
    }
    func part2() {
        let _ = solution(aStart: 1, cStart: 1)
    }
}

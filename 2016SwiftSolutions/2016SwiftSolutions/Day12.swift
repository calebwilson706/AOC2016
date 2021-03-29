//
//  Day12.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 17/03/2021.
//

import Foundation
import PuzzleBox

enum InstructionsDay12 {
    case cpy, inc, dec, jnz
}

struct Day12Instruction {
    let instruction : InstructionsDay12
    let firstValue : String
    var secondValue : String?
    
    mutating func giveSecondNumber(this value : String){
        self.secondValue = value
    }
}

func getCorrectInstructionFromStringDay12(str : String?) -> InstructionsDay12 {
    switch str {
    case "cpy":
        return .cpy
    case "inc":
        return .inc
    case "dec":
        return .dec
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
            
            if instruction != .dec && instruction != .inc {
                newInstructionItem.giveSecondNumber(this: components.last!)
            }
            
            allInstructions.append(newInstructionItem)
        }
        
        return allInstructions
    }
    
    func solution(part : Int) {
        let instructions = getInstructions()
        
        var registers = [
            "a" : 0,
            "b" : 0,
            "c" : part - 1,
            "d" : 0
        ]
        
        var index = 0
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
            }
            
            index += 1
            
        }
        
        print(registers)
    }
    
    func part1() {
        solution(part: 1)
    }
    func part2() {
        solution(part: 2)
    }
}

//
//  Day23.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 29/03/2021.
//

import Foundation
import PuzzleBox

enum InstructionsDay23 {
    case cpy, inc, dec, jnz, tgl
}

struct Day23Instruction {
    let instruction : InstructionsDay23
    let firstValue : String
    var secondValue : String?
    
    mutating func giveSecondNumber(this value : String){
        self.secondValue = value
    }
}

func getCorrectInstructionFromStringDay23(str : String?) -> InstructionsDay23 {
    switch str {
    case "cpy":
        return .cpy
    case "inc":
        return .inc
    case "dec":
        return .dec
    case "tgl":
        return .tgl
    default :
        return .jnz
    }
}

class Day23 : PuzzleClass {
    
    func getInstructions() -> [Day23Instruction] {
        var allInstructions = [Day23Instruction]()
        
        inputStringUnparsed!.components(separatedBy: "\n").forEach {
            let components = $0.components(separatedBy: " ")
            let instruction = getCorrectInstructionFromStringDay23(str: components.first)
            var newInstructionItem = Day23Instruction(instruction: instruction, firstValue: components[1], secondValue: nil)
            
            if instruction != .dec && instruction != .inc && instruction != .tgl {
                newInstructionItem.giveSecondNumber(this: components.last!)
            }
            
            allInstructions.append(newInstructionItem)
        }
        
        return allInstructions
    }
    
    func solution(amountOfA : Int) {
        var instructions = getInstructions()
        
        var registers = [
            "a" : amountOfA,
            "b" : 0,
            "c" : 0,
            "d" : 0
        ]
        
        var index = 0
        while (index < instructions.count) {
            print(index)
            let item = instructions[index]
            switch item.instruction {
            case .cpy:
                let valueBeingInserted = Int(item.firstValue) ?? registers[item.firstValue]!
                let secondArgument = item.secondValue!
                if secondArgument.first!.isLetter {
                    registers[secondArgument] = valueBeingInserted
                }
            case .inc:
                registers[item.firstValue]! += 1
            case .dec:
                registers[item.firstValue]! -= 1
            case .jnz:
                let checkShouldMove = Int(item.firstValue) ?? registers[item.firstValue]!
                index += ((checkShouldMove == 0) ? 1 : Int(item.secondValue!) ?? registers[item.secondValue!]!) - 1
            case .tgl:
                let offset = Int(item.firstValue) ?? registers[item.firstValue]!
                let indexOfChangingInstruction = index + offset
                if indexOfChangingInstruction < instructions.count {
                    let existingInstruction = instructions[indexOfChangingInstruction]
                    instructions[indexOfChangingInstruction] =
                        Day23Instruction(instruction: toggleThisInstruction(existingInstruction.instruction),
                                         firstValue: existingInstruction.firstValue,
                                         secondValue: existingInstruction.secondValue)
                }
                
            }
            
            index += 1
            
        }
        
        print(registers)
    }
    
    func part1() {
        solution(amountOfA: 7)
    }
    func part2() {
        print(89*77 + factorial(n: 12))
    }
    func toggleThisInstruction(_ instruction : InstructionsDay23) -> InstructionsDay23 {
        switch instruction {
        case .inc :
            return .dec
        case .dec, .tgl :
            return .inc
        case .jnz :
            return .cpy
        case .cpy :
            return .jnz
        }
        
    }
    
}



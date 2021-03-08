//
//  Helpers.swift
//  2016SwiftSolutions
//
//  Created by Caleb Wilson on 04/03/2021.
//

import Foundation


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func timeTest(call : () -> Void, num : Int, factor : Double = 1.0){
    let start = CFAbsoluteTimeGetCurrent()
    call()
    print("test \(num) : \((CFAbsoluteTimeGetCurrent() - start)*factor)")
}


extension String {
    func doesContainDoubleLetter() -> Bool {
        let chars = [Character](self)
        
        for index in 0 ..< (chars.count - 1) {
            if (chars[index] == chars[index + 1]){
                return true
            }
        }
        
        return false
    }
    
    
    func checkForAbba() -> Bool {
        var currIndex = 0
        
        while (currIndex + 3) < self.count {
            if self[currIndex] == self[currIndex + 3] && self[currIndex + 1] == self[currIndex + 2] && self[currIndex] != self[currIndex + 2]{
                return true
            }
            currIndex += 1
        }
        
        return false
    }
    
    func checkForAba() -> [String] {
        //returns list of corresponding bab
        var currIndex = 0
        var currentCharacter = self.first!
        var answers = [String]()
        
        while currIndex + 2 < self.count {
            let nextChar = self[currIndex + 1]
            let lastChar = self[currIndex + 2]
            
            if (currentCharacter == lastChar && currentCharacter != nextChar){
                answers.append(String(nextChar) + String(currentCharacter) + String(nextChar))
            }
            currentCharacter = nextChar
            currIndex += 1
        }
        
        
        
        return answers
    }
}



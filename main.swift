//
//  main.swift
//  Day2
//
//  Created by Marcus Gollnick on 04.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

let inputCode = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,6,19,1,5,19,23,1,23,6,27,1,5,27,31,1,31,6,35,1,9,35,39,2,10,39,43,1,43,6,47,2,6,47,51,1,5,51,55,1,55,13,59,1,59,10,63,2,10,63,67,1,9,67,71,2,6,71,75,1,5,75,79,2,79,13,83,1,83,5,87,1,87,9,91,1,5,91,95,1,5,95,99,1,99,13,103,1,10,103,107,1,107,9,111,1,6,111,115,2,115,13,119,1,10,119,123,2,123,6,127,1,5,127,131,1,5,131,135,1,135,6,139,2,139,10,143,2,143,9,147,1,147,6,151,1,151,13,155,2,155,9,159,1,6,159,163,1,5,163,167,1,5,167,171,1,10,171,175,1,13,175,179,1,179,2,183,1,9,183,0,99,2,14,0,0]
var noun = 0
var verb = 0



func runProgramm(with code: [Int]) -> [Int] {
    var code = code
    var pos = 0
    var run = true
    var loops = 0
    while run {
        loops += 1
//        print("Opcode: \(code[pos])")
        switch code[pos] {
        case 1:
            let value1 = code[code[pos+1]]
            let value2 = code[code[pos+2]]
            let resultPos = code[pos+3]
            code[resultPos] = value1 + value2
//            print("\(value1) + \(value2) = \(resultPos)/\(value1+value2)")
            pos += 4
            break
        case 2:
            let value1 = code[code[pos+1]]
            let value2 = code[code[pos+2]]
            let resultPos = code[pos+3]
            code[resultPos] = value1 * value2
//            print("\(value1) + \(value2) = \(resultPos)/\(value1*value2)")
            pos += 4
            break
        case 99:
            run = false
            break
        default:
            fatalError()
        }
    }
//    print("Loops: \(loops)")
    return code
}
let newCode = runProgramm(with: inputCode)
print("Answer2: \(newCode[0])")

print("-----------Part 2")
outerLoop: for n in (0...99).reversed() {
    noun = n
    print("Status: \(n)")
    for v in 0...99 {
        var currentCode = inputCode
        verb = v
        currentCode[1] = noun
        currentCode[2] = verb
        currentCode = runProgramm(with: currentCode)
        if currentCode[0] == 19690720 {
            print("Noun: \(noun), Verb: \(verb)")
            break outerLoop
        }
    }
}

print("Answer2: \(100*noun+verb)")


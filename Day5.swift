//
//  Day5.swift
//  Day5
//
//  Created by Marcus Gollnick on 04.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

import Foundation

let inputCode = [3,225,1,225,6,6,1100,1,238,225,104,0,1101,72,36,225,1101,87,26,225,2,144,13,224,101,-1872,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1102,66,61,225,1102,25,49,224,101,-1225,224,224,4,224,1002,223,8,223,1001,224,5,224,1,223,224,223,1101,35,77,224,101,-112,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1002,195,30,224,1001,224,-2550,224,4,224,1002,223,8,223,1001,224,1,224,1,224,223,223,1102,30,44,225,1102,24,21,225,1,170,117,224,101,-46,224,224,4,224,1002,223,8,223,101,5,224,224,1,224,223,223,1102,63,26,225,102,74,114,224,1001,224,-3256,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,58,22,225,101,13,17,224,101,-100,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1101,85,18,225,1001,44,7,224,101,-68,224,224,4,224,102,8,223,223,1001,224,5,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,7,677,226,224,102,2,223,223,1005,224,329,101,1,223,223,8,677,226,224,1002,223,2,223,1005,224,344,1001,223,1,223,1107,677,677,224,102,2,223,223,1005,224,359,1001,223,1,223,1107,226,677,224,102,2,223,223,1005,224,374,101,1,223,223,7,226,677,224,102,2,223,223,1005,224,389,101,1,223,223,8,226,677,224,1002,223,2,223,1005,224,404,101,1,223,223,1008,226,677,224,1002,223,2,223,1005,224,419,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,1108,677,226,224,1002,223,2,223,1006,224,449,101,1,223,223,1108,677,677,224,102,2,223,223,1006,224,464,101,1,223,223,1007,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,494,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,509,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,524,101,1,223,223,1107,677,226,224,102,2,223,223,1005,224,539,1001,223,1,223,108,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,1007,226,226,224,102,2,223,223,1005,224,569,101,1,223,223,8,226,226,224,102,2,223,223,1006,224,584,101,1,223,223,1008,677,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,107,226,677,224,1002,223,2,223,1005,224,614,1001,223,1,223,1108,226,677,224,102,2,223,223,1006,224,629,101,1,223,223,7,677,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,659,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,674,101,1,223,223,4,223,99,226]




func runProgramm(with code: [Int]) -> [Int] {
    var code = code
    var pos = 0
    var run = true
    var loops = 0
    while run {
        loops += 1
//        print("Opcode: \(code[pos])")
        let instruction = code[pos]
        let opCode = instruction % 100
        // 0 = false means position mode
        // 1 = true means immediate mode
        let modeP1 = instruction / 100 % 10 == 1
        let modeP2 = instruction / 1000 % 10 == 1
        switch opCode {
        case 1:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            let resultPos = code[pos+3]
            code[resultPos] = value1 + value2
//            print("\(value1) + \(value2) = \(resultPos)/\(value1+value2)")
            if resultPos != pos {
                pos += 4
            }
            break
        case 2:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            let resultPos = code[pos+3]
            code[resultPos] = value1 * value2
//            print("\(value1) + \(value2) = \(resultPos)/\(value1*value2)")
            if resultPos != pos {
                pos += 4
            }
            break
        case 3:
            let resultPos = code[pos+1]
            print("Input: ")
            if let input = readLine(),
                let value = Int(input) {
                code[resultPos] = value
                pos += 2
            } else {
               fatalError()
            }
        case 4:
            let resultPos = code[pos+1]
            print("👻 Output: \(modeP1 ? resultPos : code[resultPos])")
            if resultPos != pos {
                pos += 2
            }
        case 5:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            if value1 != 0 {
                pos = value2
            } else {
                pos += 3
            }
        case 6:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            if value1 == 0 {
                pos = value2
            } else {
                pos += 3
            }
        case 7:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            let resultPos = code[pos+3]
            if value1 < value2{
                code[resultPos] = 1
            } else {
                code[resultPos] = 0
            }
            if resultPos != pos {
                pos += 4
            }
        case 8:
            let value1 = modeP1 ? code[pos+1] : code[code[pos+1]]
            let value2 = modeP2 ? code[pos+2] : code[code[pos+2]]
            let resultPos = code[pos+3]
            if value1 == value2{
                code[resultPos] = 1
            } else {
                code[resultPos] = 0
            }
            if resultPos != pos {
                pos += 4
            }
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
_ = runProgramm(with: inputCode)

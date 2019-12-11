//
//  Day7.swift
//  Day7
//
//  Created by Marcus Gollnick on 07.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

import Foundation

let inputCode = [3,8,1001,8,10,8,105,1,0,0,21,34,59,68,89,102,183,264,345,426,99999,3,9,102,5,9,9,1001,9,5,9,4,9,99,3,9,101,3,9,9,1002,9,5,9,101,5,9,9,1002,9,3,9,1001,9,5,9,4,9,99,3,9,101,5,9,9,4,9,99,3,9,102,4,9,9,101,3,9,9,102,5,9,9,101,4,9,9,4,9,99,3,9,1002,9,5,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,99]

class IntCom {
    var code: [Int]
    var pos = 0
    var output = -1
    var run = false

    init(code: [Int]) {
        self.code = code
    }


    func runProgramm(from startPos: Int? = nil, input: [Int]) -> Int {
        if let startPos = startPos {
            pos = startPos
        }
        var input = input
        run = true
        while run {
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
                if let value = input.first {
//                    print("Input: \(value)")
                    code[resultPos] = value
                    pos += 2
                    if input.count > 1 {
                        input = Array(input.dropFirst())
                    }
                } else {
                   fatalError()
                }
            case 4:
                let resultPos = code[pos+1]
                output = modeP1 ? resultPos : code[resultPos]
//                print("👻 Output: \(output)")
                if resultPos != pos {
                    pos += 2
                }
                return output
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
                return output
            default:
                fatalError()
            }
        }
        return output
    }
}

var amplifiers = [IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode)]

var sequences: [[Int]] = []

for n1 in 0...4 {
    for n2 in 0...4 {
        for n3 in 0...4 {
            for n4 in 0...4 {
                for n5 in 0...4 {
                    if n1 != n2 && n1 != n3 && n1 != n4 && n1 != n5 &&
                        n2 != n3 && n2 != n4 && n2 != n5 &&
                        n3 != n4 && n3 != n5 &&
                        n4 != n5 {
                        sequences.append([n1,n2,n3,n4,n5])
                    }
                }
            }
        }
    }
}

var maxOutput: Int = 0
var sequenceForMaxOutput: [Int] = []
for n in 0..<sequences.count {
    var currentOutput = 0
    for i in 0..<amplifiers.count {
        currentOutput = amplifiers[i].runProgramm(from: 0, input: [sequences[n][i], currentOutput])
    }
    if currentOutput > maxOutput {
        maxOutput = currentOutput
        sequenceForMaxOutput = sequences[n]
    }
}

print("Answer 1: \(maxOutput) for \(sequenceForMaxOutput)")
print("---------------Part2")

sequences = []

for n1 in 5...9 {
    for n2 in 5...9 {
        for n3 in 5...9 {
            for n4 in 5...9 {
                for n5 in 5...9 {
                    if n1 != n2 && n1 != n3 && n1 != n4 && n1 != n5 &&
                        n2 != n3 && n2 != n4 && n2 != n5 &&
                        n3 != n4 && n3 != n5 &&
                        n4 != n5 {
                        sequences.append([n1,n2,n3,n4,n5])
                    }
                }
            }
        }
    }
}

maxOutput = 0
sequenceForMaxOutput = []
for n in 0..<sequences.count {
    var currentOutput = 0
    var initial = true
    amplifiers = [IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode),
                  IntCom(code: inputCode)]
    repeat {
        for i in 0..<amplifiers.count {
            let input = initial ? [sequences[n][i], currentOutput] : [currentOutput]
            currentOutput = amplifiers[i].runProgramm(input: input)
        }
        initial = false
    } while amplifiers.last!.run
    if currentOutput > maxOutput {
        maxOutput = currentOutput
        sequenceForMaxOutput = sequences[n]
    }
}


print("Answer 2: \(maxOutput) for \(sequenceForMaxOutput)")

//
//  Day11.swift
//  Day11
//
//  Created by Marcus Gollnick on 11.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

import Foundation

let inputCode = [3,8,1005,8,299,1106,0,11,0,0,0,104,1,104,0,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,28,1006,0,85,1,106,14,10,3,8,102,-1,8,10,1001,10,1,10,4,10,1008,8,0,10,4,10,101,0,8,58,1,1109,15,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1002,8,1,84,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,1002,8,1,105,1006,0,48,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,0,8,10,4,10,102,1,8,130,1006,0,46,1,1001,17,10,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,1002,8,1,160,2,109,20,10,3,8,102,-1,8,10,1001,10,1,10,4,10,108,0,8,10,4,10,1002,8,1,185,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,1001,8,0,207,1006,0,89,2,1002,6,10,1,1007,0,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,1,10,4,10,101,0,8,241,2,4,14,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,1,10,4,10,101,0,8,267,1,1107,8,10,1,109,16,10,2,1107,4,10,101,1,9,9,1007,9,1003,10,1005,10,15,99,109,621,104,0,104,1,21101,0,387239486208,1,21102,316,1,0,1106,0,420,21101,0,936994976664,1,21102,327,1,0,1105,1,420,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21102,1,29192457307,1,21102,1,374,0,1106,0,420,21101,0,3450965211,1,21101,0,385,0,1106,0,420,3,10,104,0,104,0,3,10,104,0,104,0,21102,1,837901103972,1,21101,408,0,0,1106,0,420,21102,867965752164,1,1,21101,0,419,0,1105,1,420,99,109,2,22102,1,-1,1,21102,40,1,2,21102,451,1,3,21102,1,441,0,1106,0,484,109,-2,2106,0,0,0,1,0,0,1,109,2,3,10,204,-1,1001,446,447,462,4,0,1001,446,1,446,108,4,446,10,1006,10,478,1102,0,1,446,109,-2,2105,1,0,0,109,4,1201,-1,0,483,1207,-3,0,10,1006,10,501,21101,0,0,-3,22101,0,-3,1,22102,1,-2,2,21101,1,0,3,21101,520,0,0,1106,0,525,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,548,2207,-4,-2,10,1006,10,548,21201,-4,0,-4,1105,1,616,22101,0,-4,1,21201,-3,-1,2,21202,-2,2,3,21101,0,567,0,1106,0,525,22101,0,1,-4,21101,1,0,-1,2207,-4,-2,10,1006,10,586,21102,1,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,608,21202,-1,1,1,21102,608,1,0,106,0,483,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2105,1,0]

class IntCom {
    enum Mode {
        case position, immediate, realtive
    }
    var code: [Int]
    var pos = 0
    var output = -1
    var run = false
    var relativeBase = 0

    init(code: [Int]) {
        self.code = Array(repeating: 0, count: 10000)
        for n in 0..<code.count{
            self.code[n] = code[n]
        }
    }

    private func getValue(for mode: Mode, offset: Int) -> Int {
        switch mode {
        case .position:
            return code[code[pos+offset]]
        case .immediate:
            return code[pos+offset]
        case .realtive:
            return code[relativeBase + code[pos+offset]]
        }
    }

    private func getResultPos(for mode: Mode, offset: Int) -> Int {
        switch mode {
        case .position,
             .immediate:
            return code[pos+offset]
        case .realtive:
            return relativeBase + code[pos+offset]
        }
    }


    func runProgramm(from startPos: Int? = nil, input: [Int]) -> Int {
        if let startPos = startPos {
            pos = startPos
        }
        var input = input
        run = true
        while run {
//            print("Opcode: \(code[pos])")
            let instruction = code[pos]
            let opCode = instruction % 100
            // 0 = false means position mode
            // 1 = true means immediate mode
            // 2 = relative Mode
            let modeP1: Mode
            let modeP2: Mode
            let modeP3: Mode
            if instruction / 100 % 10 == 1 {
                modeP1 = .immediate
            } else if instruction / 100 % 10 == 2 {
                modeP1 = .realtive
            } else {
                modeP1 = .position
            }

            if instruction / 1000 % 10 == 1 {
                modeP2 = .immediate
            } else if instruction / 1000 % 10 == 2 {
                modeP2 = .realtive
            } else {
                modeP2 = .position
            }

            if instruction / 10000 % 10 == 1 {
                modeP3 = .immediate
            } else if instruction / 10000 % 10 == 2 {
                modeP3 = .realtive
            } else {
                modeP3 = .position
            }

            switch opCode {
            case 1:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)
                let resultPos = getResultPos(for: modeP3, offset: 3)

                code[resultPos] = value1 + value2
//                print("\(value1) + \(value2) = \(resultPos)/\(value1+value2)")
                if resultPos != pos {
                    pos += 4
                }
            case 2:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)
                let resultPos = getResultPos(for: modeP3, offset: 3)

                code[resultPos] = value1 * value2
    //            print("\(value1) + \(value2) = \(resultPos)/\(value1*value2)")
                if resultPos != pos {
                    pos += 4
                }
            case 3:
                let resultPos = getResultPos(for: modeP1, offset: 1)

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
                let resultPos = getResultPos(for: modeP1, offset: 1)

                let output: Int
                switch modeP1 {
                case .position,
                     .realtive:
                    output = code[resultPos]
                case .immediate:
                     output = resultPos
                }
//                print("👻 Output: \(output)")
                if resultPos != pos {
                    pos += 2
                }
                return output
            case 5:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)

                if value1 != 0 {
                    pos = value2
                } else {
                    pos += 3
                }
            case 6:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)

                if value1 == 0 {
                    pos = value2
                } else {
                    pos += 3
                }
            case 7:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)
                let resultPos = getResultPos(for: modeP3, offset: 3)

                if value1 < value2{
                    code[resultPos] = 1
                } else {
                    code[resultPos] = 0
                }
                if resultPos != pos {
                    pos += 4
                }
            case 8:
                let value1 = getValue(for: modeP1, offset: 1)
                let value2 = getValue(for: modeP2, offset: 2)
                let resultPos = getResultPos(for: modeP3, offset: 3)

                if value1 == value2 {
                    code[resultPos] = 1
                } else {
                    code[resultPos] = 0
                }
                if resultPos != pos {
                    pos += 4
                }
            case 9:
                let value = getValue(for: modeP1, offset: 1)

                relativeBase += value
                pos += 2
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

enum Direction {
    case up, left, down, right
}
struct Pos: Hashable {
    var x: Int
    var y: Int
}
struct Panel {
    var pos: Pos
    // 0 = Black; 1 = White
    var color: Int
}

extension Panel: Equatable {
    static func == (lhs: Panel, rhs: Panel) -> Bool {
        return
            lhs.pos.x == rhs.pos.x &&
            lhs.pos.y == rhs.pos.y
    }
}

func getNewDirection(input: Int, currentDirection: Direction) -> Direction {
    if input == 0 {
        switch currentDirection {
        case .up:
            return .left
        case .left:
            return .down
        case .down:
            return .right
        case .right:
            return .up
        }
    } else if input == 1 {
        switch currentDirection {
        case .up:
            return .right
        case .left:
            return .up
        case .down:
            return .left
        case .right:
            return .down
        }
    } else {
        fatalError()
    }
}

var paintedPanels: [Panel] = []
var currentDirection = Direction.up
var x = 0
var y = 0


let intCom = IntCom(code: inputCode)
var run = true
var step = 1
var colorToPaint = 0
var currentPanelColor = 1

var maxUp = 0
var maxLeft = 0
var maxDown = 0
var maxRight = 0

repeat {

    let currentOutput = intCom.runProgramm(input: [currentPanelColor])
    if step == 1 {
        colorToPaint = currentOutput
        step = 2
    } else if step == 2 {
        currentDirection = getNewDirection(input: currentOutput, currentDirection: currentDirection)
        step = 1
        paintedPanels.append(Panel(pos: Pos(x: x, y: y), color: colorToPaint))
        switch currentDirection {
        case .up:
            y += 1
        case .left:
            x -= 1
        case .down:
            y -= 1
        case .right:
            x += 1
        }
        if let nextPanel = (paintedPanels.filter{$0.pos.x == x && $0.pos.y == y}).last {
            currentPanelColor = nextPanel.color
        } else {
            currentPanelColor = 0
        }
        if x > maxRight {
            maxRight = x
        }
        if x < maxLeft {
            maxLeft = x
        }
        if y > maxUp {
            maxUp = y
        }
        if y < maxDown {
            maxDown = y
        }
    }

    if !intCom.run {
        run = false
    }
} while run
let pos1 = Pos(x: 0, y: 0)
var p1 = Panel(pos: pos1, color: 0)
var dict: [Pos: [Panel]] = [:]
dict[pos1]?.append(p1)

let dictPaintedPanels = paintedPanels.reduce(into: [:]) {counts, panel in
    let pos = panel.pos
    if var element: [Panel] = counts[pos] as? [Panel] {
        element.append(panel)
        counts[pos] = element
    } else {
        counts[pos] = [panel]
    }
}

print("Answer 1: \(dictPaintedPanels.count)")
print("----------------------Part2")


var picture = Array(repeating: Array(repeating: "◼️", count: maxRight+abs(maxLeft)+1), count: maxUp+abs(maxDown)+1)
let startPoint = (x: abs(maxLeft), y: abs(maxDown))

for (_, value) in dictPaintedPanels {
    if let element: [Panel] = value as? [Panel],
        let lastChange = element.last {
        switch lastChange.color {
        case 0:
            picture[startPoint.y + lastChange.pos.y][startPoint.x + lastChange.pos.x] = "◼️"
        case 1:
            picture[startPoint.y + lastChange.pos.y][startPoint.x + lastChange.pos.x] = "◻️"
        default:
            fatalError()
        }
    } else {
        fatalError()
    }
}

print("Answer 2:")
for y in (0..<picture.count).reversed() {
    var str = ""
    for x in 0..<picture[0].count {
        str += picture[y][x]
    }
    print(str)
}

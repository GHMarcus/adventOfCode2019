//
//  Day6.swift
//  Day6
//
//  Created by Marcus Gollnick on 06.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

import Foundation

let start = CFAbsoluteTimeGetCurrent()

enum Input {
    static func get(_ fileName: String) -> String {
        let url = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .appendingPathComponent(fileName)

        guard let content = try? String(contentsOf: url) else {
            fatalError("Could not read content of file")
        }
        return content
    }
}

let input = Input.get("Input_Day6.txt").components(separatedBy: .newlines).filter{$0 != ""}
var leftOperants: [String] = []
var rightOperants: [String] = []
for str in input {
    let components = str.components(separatedBy: ")")
    leftOperants.append(components[0])
    rightOperants.append(components[1])
}

func findIndexOnRightSide(for operant: String) -> Int? {
    return rightOperants.firstIndex(of: operant)
}

var orbits = 0
var process = 1
var total = rightOperants.count

for n in (0..<rightOperants.count).reversed() {
    print("\(process) / \(total)")
    process += 1
    var first = leftOperants[n]
    orbits += 1
    while let next = findIndexOnRightSide(for: first) {
        orbits += 1
        first = leftOperants[next]
    }
}

print("Answer 1: \(orbits)")

print("-----------Part 2")

var youOrbits: [String] = []
var sanOrbits: [String] = []

var first = "YOU"
while let next = findIndexOnRightSide(for: first) {
    youOrbits.append(leftOperants[next])
    first = leftOperants[next]
}
first = "SAN"
while let next = findIndexOnRightSide(for: first) {
    sanOrbits.append(leftOperants[next])
    first = leftOperants[next]
}

var firstCommonYouPoint = -1
var firstCommonSanPoint = -1
for n in (0..<youOrbits.count) {
    if youOrbits[youOrbits.count-1-n] != sanOrbits[sanOrbits.count-1-n] {
        firstCommonYouPoint = youOrbits.count - n
        break
    }
}
for n in (0..<sanOrbits.count) {
    if youOrbits[youOrbits.count-1-n] != sanOrbits[sanOrbits.count-1-n] {
        firstCommonSanPoint = sanOrbits.count - n
        break
    }
}
print("Answer 2: \(firstCommonYouPoint+firstCommonSanPoint)")

let diff = CFAbsoluteTimeGetCurrent() - start
print("Took \(diff) seconds")

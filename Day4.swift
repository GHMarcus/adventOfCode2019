//
//  Day4.swift
//  Day4
//
//  Created by Marcus Gollnick on 04.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

var codesPart1: [Int] = []
var codesPart2: [Int] = []

//for n in [111111, 223450, 123789] {
for n in 128392...643281 {
    let d1 = n / 100000
    let d2 = n / 10000 % 10
    let d3 = n / 1000 % 10
    let d4 = n / 100 % 10
    let d5 = n / 10 % 10
    let d6 = n % 10

    //Condition 1: Two adjacent digits are the same (like 22 in 122345)
    if (d1==d2) || (d2==d3) || (d3==d4) || (d4==d5) || (d5==d6) {
        //Condition 2: Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679)
        if (d1<=d2) && (d2<=d3) && (d3<=d4) && (d4<=d5) && (d5<=d6) {
            codesPart1.append(n)
            var anzD1 = 0
            var anzD2 = 0
            var anzD3 = 0
            var anzD4 = 0
            var anzD5 = 0
            var anzD6 = 0
            for d in [d1,d2,d3,d4,d5,d6] {
                switch d {
                case d1:
                    anzD1 += 1
                case d2:
                    anzD2 += 1
                case d3:
                    anzD3 += 1
                case d4:
                    anzD4 += 1
                case d5:
                    anzD5 += 1
                case d6:
                    anzD6 += 1
                default:
                    continue
                }
            }
            //Condition 3: The two adjacent matching digits are not part of a larger group of matching digits
            if (anzD1==2) || (anzD2==2) || (anzD3==2) || (anzD4==2) || (anzD5==2) || (anzD6==2) {
                codesPart2.append(n)
            }
        }
    }
}


print(codesPart1)
print("Answer 1: \(codesPart1.count)")

print("-----------Part 2")
print(codesPart2)
print("Answer 2: \(codesPart2.count)")

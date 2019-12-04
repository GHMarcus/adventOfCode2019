//
//  main.swift
//  Day1
//
//  Created by Marcus Gollnick on 04.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

func getFuel(mass: Int) -> Int {
    return Int((Double(mass)/3.0).rounded(.down) - 2)
}

var masses = [119965,69635,134375,71834,124313,109114,80935,146441,120287,85102,148451,69703,143836,75280,83963,108849,133032,109359,78119,104402,89156,116946,132008,131627,124358,56060,141515,75639,146945,95026,99256,57751,148607,100505,65002,78485,84473,112331,82177,111298,131964,125753,63970,77100,90922,119326,51747,104086,141344,54409,69642,70193,109730,73782,92049,90532,147093,62719,79829,142640,85242,128001,71403,75365,90146,147194,76903,68895,56817,142352,77843,64082,106953,115590,87224,58146,134018,127111,51996,134433,148768,103906,52848,108577,77646,95930,67333,98697,55870,78927,148519,68724,93076,73736,140291,121184,111768,71920,104822,87534]

//var masses = [100756]

var fuel = 0
for mass in masses {
    var moduleFule = 0
    moduleFule = getFuel(mass: mass)

    var fuelMass = moduleFule
    repeat {
        let fuelsFuel = getFuel(mass: fuelMass)
        if fuelsFuel <= 0 {
            break
        }
        moduleFule += fuelsFuel
        fuelMass = fuelsFuel
    } while fuelMass > 0
    fuel += moduleFule
}

print(fuel)

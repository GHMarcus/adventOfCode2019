//
//  Day10.swift
//  Day10
//
//  Created by Marcus Gollnick on 10.12.19.
//  Copyright © 2019 Marcus Gollnick. All rights reserved.
//

let strInput = """
..............#.#...............#....#....
#.##.......#....#.#..##........#...#......
..#.....#....#..#.#....#.....#.#.##..#..#.
...........##...#...##....#.#.#....#.##..#
....##....#...........#..#....#......#.###
.#...#......#.#.#.#...#....#.##.##......##
#.##....#.....#.....#...####........###...
.####....#.......#...##..#..#......#...#..
...............#...........#..#.#.#.......
........#.........##...#..........#..##...
...#..................#....#....##..#.....
.............#..#.#.........#........#.##.
...#.#....................##..##..........
.....#.#...##..............#...........#..
......#..###.#........#.....#.##.#......#.
#......#.#.....#...........##.#.....#..#.#
.#.............#..#.....##.....###..#..#..
.#...#.....#.....##.#......##....##....#..
.........#.#..##............#..#...#......
..#..##...#.#..#....#..#.#.......#.##.....
#.......#.#....#.#..##.#...#.......#..###.
.#..........#...##.#....#...#.#.........#.
..#.#.......##..#.##..#.......#.###.......
...#....###...#......#..#.....####........
.............#.#..........#....#......#...
#................#..................#.###.
..###.........##...##..##.................
.#.........#.#####..#...##....#...##......
........#.#...#......#.................##.
.##.....#..##.##.#....#....#......#.#....#
.....#...........#.............#.....#....
........#.##.#...#.###.###....#.#......#..
..#...#.......###..#...#.##.....###.....#.
....#.....#..#.....#...#......###...###...
#..##.###...##.....#.....#....#...###..#..
........######.#...............#...#.#...#
...#.....####.##.....##...##..............
###..#......#...............#......#...#..
#..#...#.#........#.#.#...#..#....#.#.####
#..#...#..........##.#.....##........#.#..
........#....#..###..##....#.#.......##..#
.................##............#.......#..
"""

let lines = strInput.split { $0.isNewline }
var input: [[Character]] = []
for line in lines {
    input.append(Array(line))
}

var seen = Array(repeating: Array(repeating: 0, count: input[0].count), count: input.count)

var asteroids: [(x: Int, y: Int)] = []

for y in 0..<input.count {
    for x in 0..<input[0].count {
        if input[y][x] == "#" {
            asteroids.append((x, y))
        }
    }
}

var n = 1
var upTo = asteroids.count

for localAsteroid in asteroids {
    print("\(n) / \(upTo)")
    n += 1
    let otherAsteroids = asteroids.filter{ $0 != localAsteroid }

    //Bresenham's line algorithm
    for otherAsteroid in otherAsteroids {
        var linePoints:[(x: Int, y: Int)] = []
        let dx = abs(otherAsteroid.x - localAsteroid.x)
        let sx = localAsteroid.x < otherAsteroid.x ? 1 : -1
        let dy = -abs(otherAsteroid.y - localAsteroid.y)
        let sy = localAsteroid.y < otherAsteroid.y ? 1 : -1

        var err = dx + dy

        var x = localAsteroid.x
        var y = localAsteroid.y
        while true {

            if x == otherAsteroid.x && y == otherAsteroid.y {
                break
            }
            let e2 = 2 * err
            if e2 > dy {
                err += dy
                x += sx
            }
            if e2 < dx {
                err += dx
                y += sy
            }
            linePoints.append((x,y))
        }
        linePoints = linePoints.filter{ $0 != otherAsteroid }

        var freeSight = true
        for linePoint in linePoints {
            let dlocalToOther = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
            let dLocalToLine = Double(linePoint.y-localAsteroid.y) / Double(linePoint.x-localAsteroid.x)
            if (otherAsteroids.contains{ $0 == linePoint }) && dlocalToOther == dLocalToLine {
                freeSight = false
            }
        }
        if freeSight {
            seen[localAsteroid.y][localAsteroid.x] += 1
        }
    }
}

var max = 0
var maxPos = (x: -1, y: -1)

for y in 0..<seen.count {
    for x in 0..<seen[0].count {
        if seen[y][x] > max {
            max = seen[y][x]
            maxPos = (x,y)
        }
    }
}

print("Answer 1: \(max) for Position \(maxPos)")
print("-----------------Part2")
var vaporizedAsteroids: [(x: Int, y: Int)] = []
let localAsteroid = maxPos



// Die müssen geändert werden
var otherAsteroids = asteroids.filter{ $0 != localAsteroid }
var seenInRound = input


repeat {
    //Bresenham's line algorithm
    for otherAsteroid in otherAsteroids {
        var linePoints:[(x: Int, y: Int)] = []
        let dx = abs(otherAsteroid.x - localAsteroid.x)
        let sx = localAsteroid.x < otherAsteroid.x ? 1 : -1
        let dy = -abs(otherAsteroid.y - localAsteroid.y)
        let sy = localAsteroid.y < otherAsteroid.y ? 1 : -1

        var err = dx + dy

        var x = localAsteroid.x
        var y = localAsteroid.y
        while true {

            if x == otherAsteroid.x && y == otherAsteroid.y {
                break
            }
            let e2 = 2 * err
            if e2 > dy {
                err += dy
                x += sx
            }
            if e2 < dx {
                err += dx
                y += sy
            }
            linePoints.append((x,y))
        }
        linePoints = linePoints.filter{ $0 != otherAsteroid }

        var isHidden = false
        for linePoint in linePoints {
            let dlocalToOther = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
            let dLocalToLine = Double(linePoint.y-localAsteroid.y) / Double(linePoint.x-localAsteroid.x)
            if (otherAsteroids.contains{ $0 == linePoint }) && dlocalToOther == dLocalToLine {
                isHidden = true
            }
        }

        if isHidden {
            seenInRound[otherAsteroid.y][otherAsteroid.x] = "."
        }
    }

    var roundAsteroids: [(x: Int, y: Int)] = []

    for y in 0..<seenInRound.count {
        for x in 0..<seenInRound[0].count {
            if seenInRound[y][x] == "#" {
                roundAsteroids.append((x, y))
            }
        }
    }

    let roundAsteroidsQ1 = roundAsteroids.filter { $0.x > localAsteroid.x && $0.y < localAsteroid.y }
    let roundAsteroidsQ2 = roundAsteroids.filter { $0.x > localAsteroid.x && $0.y > localAsteroid.y }
    let roundAsteroidsQ3 = roundAsteroids.filter { $0.x < localAsteroid.x && $0.y > localAsteroid.y }
    let roundAsteroidsQ4 = roundAsteroids.filter { $0.x < localAsteroid.x && $0.y < localAsteroid.y }

    var gradientsQ1: [Double] = []
    var gradientsQ2: [Double] = []
    var gradientsQ3: [Double] = []
    var gradientsQ4: [Double] = []

    for otherAsteroid in roundAsteroidsQ1 {
        let gradient = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
        if gradient == -Double.infinity {
            print()
        }
        gradientsQ1.append(gradient)
    }
    for otherAsteroid in roundAsteroidsQ2 {
        let gradient = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
        if gradient == -Double.infinity {
            print()
        }
        gradientsQ2.append(gradient)
    }
    for otherAsteroid in roundAsteroidsQ3 {
        let gradient = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
        if gradient == -Double.infinity {
            print()
        }
        gradientsQ3.append(gradient)
    }
    for otherAsteroid in roundAsteroidsQ4 {
        let gradient = Double(otherAsteroid.y-localAsteroid.y) / Double(otherAsteroid.x-localAsteroid.x)
        if gradient == -Double.infinity {
            print()
        }
        gradientsQ4.append(gradient)
    }
    let sortedGradientsQ1 = gradientsQ1.sorted(by: <)
    let sortedGradientsQ2 = gradientsQ2.sorted(by: <)
    let sortedGradientsQ3 = gradientsQ3.sorted(by: <)
    let sortedGradientsQ4 = gradientsQ4.sorted(by: <)

    if let upAsteroid = roundAsteroids.first(where: {$0.x == localAsteroid.x && $0.y < localAsteroid.y}) {
        vaporizedAsteroids.append(upAsteroid)
    }
    for n in 0..<sortedGradientsQ1.count {
        let index = gradientsQ1.firstIndex(of: sortedGradientsQ1[n])!
        let point = roundAsteroidsQ1[index]
        vaporizedAsteroids.append(point)
    }
    if let rightAsteroid = roundAsteroids.first(where: {$0.y == localAsteroid.y && $0.x > localAsteroid.x}) {
        vaporizedAsteroids.append(rightAsteroid)
    }
    for n in 0..<sortedGradientsQ2.count {
        let index = gradientsQ2.firstIndex(of: sortedGradientsQ2[n])!
        let point = roundAsteroidsQ2[index]
        vaporizedAsteroids.append(point)
    }
    if let downAsteroid = roundAsteroids.first(where: {$0.x == localAsteroid.x && $0.y > localAsteroid.y}) {
        vaporizedAsteroids.append(downAsteroid)
    }
    for n in 0..<sortedGradientsQ3.count {
        let index = gradientsQ3.firstIndex(of: sortedGradientsQ3[n])!
        let point = roundAsteroidsQ3[index]
        vaporizedAsteroids.append(point)
    }
    if let leftAsteroid = roundAsteroids.first(where: {$0.y == localAsteroid.y && $0.x < localAsteroid.x}) {
        vaporizedAsteroids.append(leftAsteroid)
    }
    for n in 0..<sortedGradientsQ4.count {
        let index = gradientsQ4.firstIndex(of: sortedGradientsQ4[n])!
        let point = roundAsteroidsQ4[index]
        vaporizedAsteroids.append(point)
    }

    var newRoundAsteroids: [(x: Int, y: Int)] = []
    for otherAteroid in otherAsteroids {
        if !vaporizedAsteroids.contains(where: { $0.x == otherAteroid.x && $0.y == otherAteroid.y }) {
            newRoundAsteroids.append(otherAteroid)
        }
    }
    otherAsteroids = newRoundAsteroids
    for y in 0..<seenInRound.count {
        for x in 0..<seenInRound[0].count {
            seenInRound[y][x] = "."
        }
    }
    for asteroid in newRoundAsteroids {
        seenInRound[asteroid.y][asteroid.x] = "#"
    }
} while otherAsteroids.count > 0

let betAsteroid = vaporizedAsteroids[199]
print(betAsteroid)
print("Answer 2: \(betAsteroid.x*100+betAsteroid.y)")

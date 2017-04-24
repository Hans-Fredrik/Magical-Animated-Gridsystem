//: Playground - noun: a place where people can play

import UIKit


// Basic array in swift
var someInt = [Int]()
someInt.append(300)
someInt.count
someInt[0]


// Two dimensional array with initilazed values
var matrix = [[Int]](repeating: [Int](repeating: 0, count: 20), count: 20)
matrix[13][13]


// Two dimensional array with non values
var matrixEmpty = [[Int]]()

let rows = 20
let columns = 20

// This could be populated in the following way adding 0 to all values
for y in 0..<rows{
    var row = [Int]()
    
    for x in 0..<columns{
        print("\(y) | \(x)")
        row.append(y * x)
    }
    
    matrixEmpty.append(row)
}


for y in 0..<rows {
    var row = ""
    
    for x in 0..<columns{
        var stringFormated = String(format: "% 4d", matrixEmpty[y][x])
        row.append(stringFormated)
    }
    
    print(row)
}





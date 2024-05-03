import UIKit

func transposeMatrixInPlace(_ matrix: inout [[Int]]) {
	let n = matrix.count
	
	for i in 0..<n {
		for j in (i + 1)..<n {
			let temp = matrix[i][j]
			matrix[i][j] = matrix[j][i]
			matrix[j][i] = temp
		}
	}
}

var matrix: [[Int]] = [
	[1, 2, 3],
	[4, 5, 6],
	[7, 8, 9]
]

print("Исходная матрица:")
for row in matrix {
	print(row)
}

transposeMatrixInPlace(&matrix)

print("Транспонированная матрица:")
for row in matrix {
	print(row)
}


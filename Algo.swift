// Solution A.
//Algo
func testString(inputString: String, n: Int) {
    var str = ""
    let maxChar = 122
    let minChar = 26
    for char in inputString.utf8 {
        var index = n
        if Int(char) + index > maxChar {
            index -= (maxChar - Int(char))
        }
        if Int(char) + index > maxChar {
            index -= maxChar - Int(char)
            index %= minChar
            str += "\(Character(UnicodeScalar(96 + index)!))"
        } else {
            str += "\(Character(UnicodeScalar(char + UInt8(index))))"
        }
        index = n
    }
    
    // Output
    print(str)
}

// Driver Code
testString(inputString: "abcd", n: 2)

// Driver Code - Case 2
testString(inputString: "alpha", n: 2)

// Driver Code - Case 3
testString(inputString: "zxcd", n: 2)


/*
 // Solution B.
 
 There are two disadvantages of using ascii to resolve the problem.
 1. Swift uses the unicode scalar for converting ascii to char and char to ascii. These are operations are constlier.
 2. This alogrithm may fail for different characters e.g.
 
 Character("á").ascii will generate nil while
 Character("a").ascii    // 97
 
 */

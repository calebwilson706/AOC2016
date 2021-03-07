import java.io.File

object Day4 {
    private val strings = File("/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day4Input.txt")
        .readText()
        .split("\n")

        fun part1() {
            println(strings.fold(0, { acc, str ->
                acc + if (regexGetChecksum(str) == getFrequencyMapOfCharsForLine(str)) {
                    str.filter { it.isDigit() }.toInt()
                } else {
                    0
                }
            }))
        }

        fun part2() {
            val validStrings = strings.filter { regexGetChecksum(it) == getFrequencyMapOfCharsForLine(it) }
            val regex = "northpole-object-storage-([0-9]{3}).+".toRegex()

            for (string in validStrings) {
                val decryptedString = decrypt(string,
                    string.filter { it.isDigit() }.toInt()
                )
                val regexParsed = regex.find(decryptedString)

                if (regexParsed != null) {
                    val (num) = regexParsed.destructured
                    println(num)
                    break
                }

            }

        }


}

fun regexGetChecksum(str : String) : String {
    val regexStatement = ".+[0-9]{3}\\[([a-z]{5}).".toRegex()
    //println(str)
    val (answer) = regexStatement.find(str)!!.destructured
    return answer
}

fun getFrequencyMapOfCharsForLine(str : String): String {
    var working = str
    working = working.dropLast(11)

    val map = working.filter { it.isLetter() }
        .groupingBy { it }
        .eachCount()
        .toList()
        .sortedWith(compareBy( {-it.second}, {it.first}))
        .toMap()
    var answer = ""
    var index = 0

    for (item in map){
        answer += item.key
        index++

        if (index == 5 ){
            break
        }
    }
    return answer
}

fun decrypt(thisString : String, by : Int): String {
    val alphabet = "abcdefghijklmnopqrstuvwxyz".toCharArray()

    var working = ""
    thisString.forEach {
        if (alphabet.contains(it)) {
            var index = (alphabet.indexOf(it) + by) % 26
            if ((0..25).contains(index)) {
                working += alphabet[index]
            } else {
                if (index < 0) {
                    index += 26
                } else {
                    index -= 26
                }
                working += alphabet[index]
            }
        } else working += it
    }

    return working

}
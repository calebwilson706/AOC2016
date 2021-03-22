import java.lang.StringBuilder

object Day16 {
    private const val startingString = "10011111011011001"

    fun part1() {
        val finalString = findStringWhichExceedsLength(startingString, 272).subSequence(0, 272).toString()
        println(getChecksumFor(finalString))
    }

    fun part2() {
        val finalString = findStringWhichExceedsLength(startingString, 35651584).subSequence(0, 35651584).toString()
        println(getChecksumFor(finalString))
    }

    private fun findStringWhichExceedsLength(a : String, maxSize : Int) : String {
        val acc = StringBuilder()
        a.reversed().forEach {
            if (it == '1') {
                acc.append('0')
            } else {
                acc.append('1')
            }
        }

        val newResult = a + "0" + acc

        return if (newResult.length < maxSize) {
            findStringWhichExceedsLength(newResult, maxSize)
        } else {
            newResult
        }

    }

    private fun getChecksumFor(string : String) : String {
        val chunksOfString = string.chunked(2)
        var answer = StringBuilder()

        chunksOfString.forEach {
            answer.append(if (it[0] == it[1]) {
                '1'
            } else {
                '0'
            })
        }

        return if (answer.length % 2 == 0){
            getChecksumFor(answer.toString())
        } else {
            answer.toString()
        }
    }

}


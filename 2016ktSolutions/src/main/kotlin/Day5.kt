object Day5 {
    private const val input = "wtnhxymk"

    fun part1() {
        var shouldContinue = true
        var num = 0
        val passwords = mutableListOf<String>()

        while (shouldContinue) {
            val hashedStr = md5(input + "$num")
            if (hashedStr.subSequence(0,5) == "00000") {
                passwords.add(hashedStr)
                num++
                shouldContinue = passwords.size != 8
            } else {
                num++
            }
        }

        print(passwords.map { it[5] }.joinToString(""))
    }
    fun part2() {
        var shouldContinue = true
        var num = 0
        val charactersForPassword = mutableMapOf<Int, Char>()

        while (shouldContinue) {
            val hashedStr = md5(input + "$num")
            if (hashedStr.subSequence(0,5) == "00000") {
                println(hashedStr)
                if (hashedStr[5].isDigit()) {
                    val floor = hashedStr[5].toString().toInt()
                    println(floor)
                    if (floor <= 7) {
                        if (charactersForPassword[floor] == null) {
                            charactersForPassword[floor] = hashedStr[6]
                        }
                    }
                }
                println(charactersForPassword)
                num++
                shouldContinue = charactersForPassword.size != 8
            } else {
                num++
            }
        }

        print(charactersForPassword)
    }

}
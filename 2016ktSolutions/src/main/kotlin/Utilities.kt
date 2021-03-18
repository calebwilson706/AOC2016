import java.math.BigInteger
import java.security.MessageDigest

fun md5(input:String): String {
    val md = MessageDigest.getInstance("MD5")
    return BigInteger(1, md.digest(input.toByteArray())).toString(16).padStart(32, '0')
}
fun md5Recursive(input : String, amountOfRepeats : Int) : String{
    val md = MessageDigest.getInstance("MD5")
    val hashed = BigInteger(1, md.digest(input.toByteArray())).toString(16).padStart(32, '0')

    return if (amountOfRepeats == 1) {
        hashed
    } else {
        md5Recursive(hashed, amountOfRepeats - 1)
    }
}
fun numberOfDigits(i : Int) = i.toString().length
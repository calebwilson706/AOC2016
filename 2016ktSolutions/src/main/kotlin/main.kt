import kotlin.system.measureTimeMillis
import kotlin.time.measureTime

fun main(args: Array<String>) {
    println( measureTimeMillis {
        Day14.part2()
    })
}
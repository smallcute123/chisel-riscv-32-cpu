// See README.md for license details.

package passthrough

import chisel3._

/**
  * Compute GCD using subtraction method.
  * Subtracts the smaller from the larger until register y is zero.
  * value in register x is then the GCD
  */
// Chisel Code, but pass in a parameter to set widths of ports
class Passthrough extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val out = Output(UInt(4.W))
  })
  io.out := io.in
}

class PassthroughGenerator(width: Int) extends Module { 
  val io = IO(new Bundle {
    val in = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })
  io.out := io.in
}

// Let's now generate modules with different widths
object Passthrough extends App {
  println(getVerilogString(new PassthroughGenerator(10)))
  println(getVerilogString(new PassthroughGenerator(20)))
}

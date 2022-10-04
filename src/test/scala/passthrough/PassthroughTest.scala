// See README.md for license details.

package passthrough

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PassthroughTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "PassthroughGenerator"
  it should "pass through bits" in {
    test(new PassthroughGenerator(3)) { c =>
      c.io.in.poke(0.U)     // Set our input to value 0
      c.io.out.expect(0.U)  // Assert that the output correctly has 0
      c.io.in.poke(1.U)     // Set our input to value 1
      c.io.out.expect(1.U)  // Assert that the output correctly has 1
      c.io.in.poke(2.U)     // Set our input to value 2
      c.io.out.expect(2.U)  // Assert that the output correctly has 2
    }
    println("SUCCESS!!") // Scala Code: if we get here, our tests passed!
  }
}


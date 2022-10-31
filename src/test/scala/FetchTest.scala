
package fetch

import chisel3._
import org.scalatest._
import chiseltest._

class FetchTest extends FreeSpec with ChiselScalatestTester with Matchers
{
  "fetch test" in {
    test(new Top()) { c =>
      while(!c.io.exit.peek().litToBoolean){
      //for(i <- 0 until 100){
        println(c.io.exit.peek())
        //println(c.core.inst.peek())
        c.clock.step(1)
      //}
    }
  }
}
}

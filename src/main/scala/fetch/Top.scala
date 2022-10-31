package  fetch

import chisel3._
import chisel3.stage.ChiselStage

class Top extends Module {
  val io = IO(new Bundle{
    val exit = Output(Bool())
  })
  val core = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem //对例化的接口class（ImemPortlo）的连线
  io.exit := core.io.exit
}
 object fetch_Generator extends App{
   println((new ChiselStage).emitVerilog(new Top(),args))
 }
package riscv_test

import chisel3._ 
import chisel3.stage.ChiselStage
import common.Consts._
import common.Instructions._ 

class Top extends Module {
  val io = IO(new Bundle{
    val exit = Output(Bool())
  })
  val core = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem //对例化的接口class（ImemPortlo）的连线
  core.io.dmem <> memory.io.dmem
  io.exit := core.io.exit
}
 object fetch_Generator extends App{
   println((new ChiselStage).emitVerilog(new Top(),args))
 }
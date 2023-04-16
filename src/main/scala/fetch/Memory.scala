package fetch

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import common.Consts._
import common.Instructions._ 

class DmemPortIo extends Bundle {
  val addr  = Input(UInt(WORD_LEN.W))
  val rdata = Output(UInt(WORD_LEN.W))
  val wen   = Input(Bool())           
  val wdata = Input(UInt(WORD_LEN.W)) 
}
class ImemPortIo extends Bundle{
    val addr = Input(UInt(WORD_LEN.W))
    val inst = Output(UInt(WORD_LEN.W))
}
class Memory extends Module{
    val io = IO(new Bundle{
        val imem = new ImemPortIo()
        val dmem = new DmemPortIo()
    })
    val mem = Mem(16384,UInt(8.W))
    loadMemoryFromFile(mem, "src/hex/fetch.hex")
     //拿了四个中间wire来取东西,最后拼接起来送去inst

    io.imem.inst := Cat(
    mem(io.imem.addr + 3.U(WORD_LEN.W)), //0+3 3之所以要用32位 是为了跟前面的addr的位宽对齐
    mem(io.imem.addr + 2.U(WORD_LEN.W)), //0+2
    mem(io.imem.addr + 1.U(WORD_LEN.W)), //0+1
    mem(io.imem.addr)//比如io.imem.addr的数字是0，那么意思就是把0的位置上的那个8bit宽的，concatenate 1，2，3位置上的内容
  )
   io.dmem.rdata := Cat(
    mem(io.dmem.addr + 3.U(WORD_LEN.W)),
    mem(io.dmem.addr + 2.U(WORD_LEN.W)),
    mem(io.dmem.addr + 1.U(WORD_LEN.W)),
    mem(io.dmem.addr)
  )

   when(io.dmem.wen){
    mem(io.dmem.addr) := io.dmem.wdata(7,0)
    mem(io.dmem.addr+1.U) := io.dmem.wdata(15,8)
    mem(io.dmem.addr+2.U) := io.dmem.wdata(23,16)
    mem(io.dmem.addr+3.U) := io.dmem.wdata(31,24)
  }

}

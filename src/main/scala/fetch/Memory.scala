package fetch

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._
import chisel3.until.experimental.loadMemoryFromFile
import common.Consts._

class ImemPortIo extends Bundle{
    val addr = Input(UInt(WORD_LEN.W))
    val inst = Output(UInt(WORD_LEN.W))
}
class Memory extends Module{
    val io = IO(new Bundle{
        val imem = new ImemPortIo()
    })
    val mem=Mem(16384,UInt(8.W))
    loadMemoryFromFile

}
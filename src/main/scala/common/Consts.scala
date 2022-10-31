package common

import chisel3._
import chisel3.util._

object Consts{
    val WORD_LEN      = 32
    val START_ADDR    = 0.U(WORD_LEN.W)
    //1
    val EXE_LEN = 5
    val ALU_X = 0.U(EXE_LEN.W)
    val ALU_ADD = 1.U(EXE_LEN.W)

    //2
    val OP1_LEN = 2
    val OP1_RS1 = 0.U(OP1_LEN.W)

    //3
    val OP2_LEN = 2
    val OP2_X = 0.U(OP1_LEN.W)
    val OP2_RS2 = 1.U(OP1_LEN.W)
    val OP2_IMI = 2.U(OP2_LEN.W)
    val OP2_IMS = 3.U(OP1_LEN.W)//IMS 与 IMM 只是不同指令中规定的立即数的位置不同
    //4
    val MEN_LEN = 2
    val MEN_X = 0.U
    val MEN_S = 1.U

     //5
    val REN_LEN = 2
    val REN_X = 0.U
    val REN_S = 1.U
  
    //6
    val WB_SEL_LEN = 3
    val WB_X = 0.U(WB_SEL_LEN.W)
    val WB_MEM = 1.U(WB_SEL_LEN.W)


}

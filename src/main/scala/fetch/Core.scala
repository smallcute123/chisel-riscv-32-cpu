package  fetch

import chisel3._
import chisel3.stage.ChiselStage
import common.Consts._

class Core extends Module{
    val io = IO (new Bundle{
        val dmem = Flipped(new DmemPortIo())
        val imem = Flipped(new ImemPortIo())
        val exit = Output(Bool())
    })
    val regfile = Mem(32,UInt(WORD_LEN.W))
    //****************************
    //Instruction Fetch(IF) Stage
    val pc_reg = RegInit(0.U(WORD_LEN.W))//0
    //val pc_reg_temp = 0.U(WORD_LEN.W)//0
    pc_reg  := pc_reg + 4.U(WORD_LEN.W)
   // pc_reg := Mux( io.imem.inst === 0.U(WORD_LEN.W), pc_reg , pc_reg + 4.U(WORD_LEN.W))
    io.imem.addr := pc_reg
    val inst = io.imem.inst//暂时只是把mem里的inst拿进肚子里,这种中间的wire,在chisel里就会被优化掉,最后生成的结果是直接input做个判断然后就连去io_exit
    //*****************************
    //Instruction Decode(ID) Stage
    val rs1_addr = inst(19,15)
    val rs2_addr = inst(24,20)
    val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.W)),regfile(rs1_addr),0.U(WORD_LEN.W))//从通用寄存器第一位中取的数字永远都要是0，既然如此，取第一位数字的时候，就不用真的去执行“取”操作，而是只要加个mux判断，如果是要取第一位的值，不用取，直接把返回值设成0。
    val rs2_data = regfile(rs2_addr)
    val imm_s =  Cat(inst(31,25),inst(11,7))
    val imm_s_sext = Cat(Fill(20,imm_s(11)),imm_s)//将imm_s扩展到32位
    val wb_addr = inst(11,7)

    val exe_fun::op1_sel::op2_sel::mem_wen::rf_wen::csr_cmd::Nil = csignals
    val csignals = ListLookup(inst,
        List(ALU_X,OP1_X,OP2_X,MEN_X,REN_X,WB_X,CSR_X),
        Array(
            LW -> List(ALU_ADD,OP1_RS1,OP2_IMI,MEN_X,REN_S,WB_)
            SW -> List(ALU_ADD,OP1_RS1,OP2_IMS,MEN_S,REN_X,WB_X,CSR_X)
        ))//ListLookup的功能：信号线csignals按照inst的内容来设置，inst是用来进行match的，
        //The third argument is an Array of "key"->"value" tuples. The inst is matched against the keys to find a match and the csignals is set to the value part if a match is found.
    val op1_data = MuxCase(0.U(WORD_LEN.W),
        Seq(
        (op1_sel === OP1_RS1) -> rs1_data
        )
    )
    val op2_data = MuxCase(0.U(WORD_LEN.W),
        Seq(
            (op2_sel === OP2_RS2)-> rs2_data
            (op2_sel === OP2_IMS)-> imm_s_sext
        )
    )
    //*****************************
    //Excute Stage(ES)
    val alu_out = MuxCase(0.U(WORD_LEN.W),
        Seq(
            (exe_fun === ALU_ADD) -> (op1_data + op2_data)
        )
    )
    //*****************************
    //access memory
    when(mem_wen === MEN_S){
        io.dmem.wen := mem_wen
        io.dmem.addr:= alu_out
        io.dmem.wdata := rs2_data
    }




  //**********************************
  //Debug
    io.exit := (inst === 0x5872E24D.U(WORD_LEN.W))//遇到特定的instruction 会拉高，是testbench判断测试结束的标志
    printf(p"pc_reg : 0x${Hexadecimal(pc_reg)}\n")
   // printf(p"pc_reg_temp : 0x${Hexadecimal(pc_reg_temp)}\n")
    
    printf(p"inst : 0x${Hexadecimal(inst)}\n")
    printf("--------\n")
    
}
object fetch_core_Generator extends App
{
    println((new ChiselStage).emitVerilog(new Core,args))
}

package riscv_test

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._
import common.Consts._
import common.Instructions._ // 追加

class Core extends Module{
    val io = IO (new Bundle{
        val dmem = Flipped(new DmemPortIo())
        val imem = Flipped(new ImemPortIo())
        val exit = Output(Bool())
    })
    val regfile = Mem(32,UInt(WORD_LEN.W))
    val csrfile = Mem(4096, UInt(WORD_LEN.W))
    //****************************
    //Instruction Fetch(IF) Stage
    val pc_reg = RegInit(0.U(WORD_LEN.W))//0
    val inst = io.imem.inst//暂时只是把mem里的inst拿进肚子里,这种中间的wire,在chisel里就会被优化掉,最后生成的结果是直接input做个判断然后就连去io_exit
    io.dmem.wdata := RegInit(0.U((WORD_LEN.W))) // initialize to 0
    io.dmem.wen := RegInit(false.B) // initialize to false
    io.dmem.addr := RegInit(0.U((WORD_LEN.W))) // initialize to 0
    //val pc_reg_temp = 0.U(WORD_LEN.W)//0
   // pc_reg  := pc_reg + 4.U(WORD_LEN.W)
   // pc_reg := Mux( io.imem.inst === 0.U(WORD_LEN.W), pc_reg , pc_reg + 4.U(WORD_LEN.W))
    io.imem.addr := pc_reg
    val alu_out = Wire(UInt(WORD_LEN.W))
    val br_flag = Wire(Bool())
    val br_target = Wire(UInt(WORD_LEN.W))
    val pc_next = MuxCase(pc_reg+4.U,
    Seq(
        br_flag -> br_target,
        (inst === JAL||inst === JALR)-> alu_out,
        (inst === ECALL) -> csrfile(0x305)
    )

    )
    pc_reg:= pc_next
    io.exit := (inst === 0x5872e24d.U(WORD_LEN.W))//遇到特定的instruction 会拉高，是testbench判断测试结束的标志

    //*****************************
    //Instruction Decode(ID) Stage
    val rs1_addr = inst(19,15)
    val rs2_addr = inst(24,20)
    val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.W)),regfile(rs1_addr),0.U(WORD_LEN.W))//从通用寄存器第一位中取的数字永远都要是0，既然如此，取第一位数字的时候，就不用真的去执行“取”操作，而是只要加个mux判断，如果是要取第一位的值，不用取，直接把返回值设成0。
    val rs2_data = Mux((rs2_addr =/= 0.U(WORD_LEN.W)),regfile(rs2_addr),0.U(WORD_LEN.W))
    val imm_s = Cat(inst(31,25),inst(11,7))
    val imm_s_sext = Cat(Fill(20,imm_s(11)),imm_s)//将imm_s扩展到32位
    val imm_i = inst(31,20)
    val imm_i_sext = Cat(Fill(20,imm_i(11)),imm_i)
    val wb_addr = inst(11,7)
    val imm_j = Cat(inst(31), inst(19,12), inst(20), inst(30,21))
    val imm_j_sext = Cat(Fill(11,imm_j(19)),imm_j,0.U(1.U))
    val imm_u = Cat(inst(31,12))
    val imm_u_sext = Cat(imm_u, Fill(12,0.U))
    val imm_b = Cat(inst(31),inst(7),inst(30,25),inst(11,8))
    val imm_b_sext = Cat(Fill(19,imm_b(11)),imm_b,0.U(1.U))
    val imm_z = inst(19,15)
    val imm_z_sext= Cat(Fill(27,0.U),imm_z)
    val csignals = ListLookup(inst,
        List(ALU_X,OP1_X,OP2_X,MEN_X,REN_X,WB_X,CSR_X),
        Array(
            SW -> List(ALU_ADD,OP1_RS1,OP2_IMS,MEN_S,REN_X,WB_X,CSR_X),
            LW -> List(ALU_ADD,OP1_RS1,OP2_IMI,MEN_X,REN_S,WB_MEM,CSR_X),
            //加减运算
            ADD   -> List(ALU_ADD  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            ADDI  -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            SUB   -> List(ALU_SUB  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            //逻辑运算
            AND   -> List(ALU_AND  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            OR    -> List(ALU_OR   , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            XOR   -> List(ALU_XOR  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            ANDI  -> List(ALU_AND  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            ORI   -> List(ALU_OR   , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            XORI  -> List(ALU_XOR  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            //位移运算
            SLL   -> List(ALU_SLL  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            SRL   -> List(ALU_SRL  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            SRA   -> List(ALU_SRA  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            SLLI  -> List(ALU_SLL  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            SRLI  -> List(ALU_SRL  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            SRAI  -> List(ALU_SRA  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            //比较运算
            SLT   -> List(ALU_SLT  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            SLTU  -> List(ALU_SLTU , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
            SLTI  -> List(ALU_SLT  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            SLTIU -> List(ALU_SLTU , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
            //JAL
            JAL   -> List(ALU_ADD , OP1_PC, OP2_IMJ, MEN_X, REN_S, WB_PC, CSR_X),
            LUI   -> List(ALU_ADD , OP1_X, OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X),
            AUIPC -> List(ALU_ADD , OP1_PC, OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X),
            JALR  -> List(ALU_JALR, OP1_PC, OP2_IMI, MEN_X, REN_S, WB_PC, CSR_X),
            //branch
            BEQ   -> List(BR_BEQ   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            BNE   -> List(BR_BNE   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            BGE   -> List(BR_BGE   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            BGEU  -> List(BR_BGEU  , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            BLT   -> List(BR_BLT   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            BLTU  -> List(BR_BLTU  , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X),
            //csr
            CSRRW -> List(ALU_COPY, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_W),
            CSRRWI-> List(ALU_COPY, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_W),
            CSRRS -> List(ALU_COPY, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_S),
            CSRRSI-> List(ALU_COPY, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_S),
            CSRRC -> List(ALU_COPY, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_C),
            CSRRCI-> List(ALU_COPY, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_C),
            //
            ECALL -> List(ALU_X    , OP1_X  , OP2_X  , MEN_X, REN_X, WB_X  , CSR_E)
            
        ))//ListLookup的功能：信号线csignals按照inst的内容来设置，inst是用来进行match的，
        //The third argument is an Array of "key"->"value" tuples. The inst is matched against the keys to find a match and the csignals is set to the value part if a match is found.
    val exe_fun::op1_sel::op2_sel::mem_wen::rf_wen::wb_sel::csr_cmd::Nil = csignals
    val op1_data = MuxCase(0.U(WORD_LEN.W),
        Seq(
        (op1_sel === OP1_RS1) -> rs1_data,
        (op1_sel === OP1_PC ) -> pc_reg,
        (op1_sel === OP1_IMZ) -> imm_z_sext

        )
    )
    val op2_data = MuxCase(0.U(WORD_LEN.W),
        Seq(
            (op2_sel === OP2_RS2)-> rs2_data,
            (op2_sel === OP2_IMS)-> imm_s_sext,
            (op2_sel === OP2_IMI)-> imm_i_sext,
            (op2_sel === OP2_IMJ)-> imm_j_sext,
            (op2_sel === OP2_IMU)-> imm_u_sext
        )
    )
    //*****************************
    //Excute Stage(ES)
    val inv_one = Cat(Fill(WORD_LEN-1,1.U(1.W)),0.U(1.U))
    alu_out := MuxCase(0.U(WORD_LEN.W),
        Seq(
            (exe_fun === ALU_ADD) -> (op1_data + op2_data),
            (exe_fun === ALU_SUB) -> (op1_data - op2_data),
            (exe_fun === ALU_AND) -> (op1_data & op2_data),
            (exe_fun === ALU_OR)  -> (op1_data | op2_data),
            (exe_fun === ALU_XOR) -> (op1_data ^ op2_data),
            (exe_fun === ALU_SLL) -> (op1_data << op2_data(4,0))(31,0),//op2_data(4,0)因为只要五位就可以表示32位的偏移量
            (exe_fun === ALU_SRL) -> (op1_data >> op2_data(4,0)),
            (exe_fun === ALU_SRA) -> (op1_data.asSInt() >> op2_data(4, 0)).asUInt(),//asSInt相对于verilog的signed
            (exe_fun === ALU_SLT) -> (op1_data.asSInt() < op2_data.asSInt()).asUInt(),
            (exe_fun === ALU_SLTU) -> (op1_data < op2_data).asUInt(),
            (exe_fun === ALU_JALR) -> ((op1_data+op2_data) & inv_one),
            (exe_fun === ALU_COPY) -> (op1_data)


        )
    )
    br_flag := MuxCase(false.B,
    Seq(
            (exe_fun === BR_BEQ)  ->  (op1_data === op2_data),
            (exe_fun === BR_BNE)  -> !(op1_data === op2_data),
            (exe_fun === BR_BLT)  ->  (op1_data.asSInt() < op2_data.asSInt()),
            (exe_fun === BR_BGE)  -> !(op1_data.asSInt() < op2_data.asSInt()),
            (exe_fun === BR_BLTU) ->  (op1_data < op2_data),
            (exe_fun === BR_BGEU) -> !(op1_data < op2_data)
    ))
    br_target := pc_reg + imm_b_sext
    //*****************************
    //access memory
        io.dmem.wen := mem_wen
        io.dmem.addr:= alu_out
        io.dmem.wdata := rs2_data
    val csr_addr = Mux(csr_cmd === CSR_E, 0x342.U(CSR_ADDR_LEN.W),inst(31,20))
    val csr_rdata = csrfile(csr_addr)
    val csr_wdata = MuxCase(0.U(WORD_LEN.W),
    Seq(
        (csr_cmd === CSR_W)-> alu_out,
        (csr_cmd === CSR_S)-> (csr_rdata & ~alu_out),
        (csr_cmd === CSR_C)-> (csr_rdata | alu_out),
        (csr_cmd === CSR_E)-> 11.U(WORD_LEN.W)
    ))
    when(csr_cmd>0.U){
        csrfile(wb_addr) := csr_wdata
    }

    //write back
    val wb_data = MuxCase(alu_out,
    Seq(
        (wb_sel === WB_MEM) -> io.dmem.rdata,
        (wb_sel === WB_PC) -> (pc_reg+4.U),
        (wb_sel === WB_CSR) -> csr_rdata
    )
    )
    
    when(rf_wen === REN_S){
        regfile(wb_addr) := wb_data
    }




  //**********************************
  //Debug
//     printf(p"pc_reg : 0x${Hexadecimal(pc_reg)}\n")
//    // printf(p"pc_reg_temp : 0x${Hexadecimal(pc_reg_temp)}\n")
    
//     printf(p"inst : 0x${Hexadecimal(inst)}\n")
//     printf("--------\n")
    
// }
  printf(p"pc_reg     : 0x${Hexadecimal(pc_reg)}\n")
  printf(p"inst       : 0x${Hexadecimal(inst)}\n")
  printf("===LW===\n")
  printf(p"rs1_addr (addr of regfile for \"mem addr\"): $rs1_addr\t")
  printf(p"rs1_data (\"addr for mem\"): 0x${Hexadecimal(rs1_data)}\n")
  printf(p"imm_i: ${imm_i}\t")
  printf(p"imm_i_sext: ${imm_i_sext}\n")
  printf(p"rd/wb_addr (addr of regfile for mem date)   : $wb_addr\n")
  printf(p" (load mem data)  : 0x${Hexadecimal(wb_data)}\n")

  printf("===SW===\n")
  printf(p"save mem addr pointer (rs1_addr)   : $rs1_addr\t")
  printf(p"save mem addr (rs1_data): 0x${Hexadecimal(rs1_data)}\n")
  printf(p"imm_s  : ${imm_s}\t")
  printf(p"imm_s_sext  : ${imm_s_sext}\n")
  printf(p"save mem data ponter (rs2_addr)   : $rs2_addr\t")
  printf(p"save mem data (rs2_data): 0x${Hexadecimal(rs2_data)}\n")
  printf(p"dmem.addr  : ${io.dmem.addr}\n")
  printf(p"dmem.wen   : ${io.dmem.wen}\n")                  // 追加
  printf(p"dmem.wdata : 0x${Hexadecimal(io.dmem.wdata)}\n") // 追加
  printf("---------\n")
}
object fetch_core_Generator extends App
{
    println((new ChiselStage).emitVerilog(new Core,args))
}

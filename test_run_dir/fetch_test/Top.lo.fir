circuit Top :
  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_dmem_addr : UInt<32>
    input io_dmem_rdata : UInt<32>
    output io_dmem_wen : UInt<1>
    output io_dmem_wdata : UInt<32>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    output io_exit : UInt<1>

    mem regfile : @[Core.scala 15:22]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => rs1_data_MPORT
      reader => rs2_data_MPORT
      writer => MPORT
      read-under-write => undefined
    reg pc_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_reg) @[Core.scala 18:25]
    reg io_dmem_wdata_REG : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_dmem_wdata_REG) @[Core.scala 19:29]
    reg io_dmem_wen_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_dmem_wen_REG) @[Core.scala 20:27]
    reg io_dmem_addr_REG : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_dmem_addr_REG) @[Core.scala 21:28]
    node _pc_reg_T = add(pc_reg, UInt<32>("h4")) @[Core.scala 23:23]
    node _pc_reg_T_1 = tail(_pc_reg_T, 1) @[Core.scala 23:23]
    node rs1_addr = bits(io_imem_inst, 19, 15) @[Core.scala 29:24]
    node rs2_addr = bits(io_imem_inst, 24, 20) @[Core.scala 30:24]
    node _rs1_data_T = neq(rs1_addr, UInt<32>("h0")) @[Core.scala 31:34]
    node rs1_data = mux(_rs1_data_T, regfile.rs1_data_MPORT.data, UInt<32>("h0")) @[Core.scala 31:23]
    node _rs2_data_T = neq(rs2_addr, UInt<32>("h0")) @[Core.scala 32:34]
    node rs2_data = mux(_rs2_data_T, regfile.rs2_data_MPORT.data, UInt<32>("h0")) @[Core.scala 32:23]
    node _imm_s_T = bits(io_imem_inst, 31, 25) @[Core.scala 33:25]
    node _imm_s_T_1 = bits(io_imem_inst, 11, 7) @[Core.scala 33:37]
    node imm_s = cat(_imm_s_T, _imm_s_T_1) @[Cat.scala 31:58]
    node _imm_s_sext_T = bits(imm_s, 11, 11) @[Core.scala 34:39]
    node _imm_s_sext_T_1 = bits(_imm_s_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_sext_T_2 = mux(_imm_s_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_s_sext = cat(_imm_s_sext_T_2, imm_s) @[Cat.scala 31:58]
    node imm_i = bits(io_imem_inst, 31, 20) @[Core.scala 35:21]
    node _imm_i_sext_T = bits(imm_i, 11, 11) @[Core.scala 36:39]
    node _imm_i_sext_T_1 = bits(_imm_i_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_sext_T_2 = mux(_imm_i_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_i_sext = cat(_imm_i_sext_T_2, imm_i) @[Cat.scala 31:58]
    node wb_addr = bits(io_imem_inst, 11, 7) @[Core.scala 37:23]
    node _csignals_T = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_1 = eq(UInt<14>("h2023"), _csignals_T) @[Lookup.scala 31:38]
    node _csignals_T_2 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_3 = eq(UInt<14>("h2003"), _csignals_T_2) @[Lookup.scala 31:38]
    node _csignals_T_4 = mux(_csignals_T_3, UInt<5>("h1"), UInt<5>("h0")) @[Lookup.scala 34:39]
    node csignals_0 = mux(_csignals_T_1, UInt<5>("h1"), _csignals_T_4) @[Lookup.scala 34:39]
    node _csignals_T_5 = mux(_csignals_T_3, UInt<2>("h0"), UInt<2>("h2")) @[Lookup.scala 34:39]
    node csignals_1 = mux(_csignals_T_1, UInt<2>("h0"), _csignals_T_5) @[Lookup.scala 34:39]
    node _csignals_T_6 = mux(_csignals_T_3, UInt<2>("h2"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node csignals_2 = mux(_csignals_T_1, UInt<2>("h3"), _csignals_T_6) @[Lookup.scala 34:39]
    node _csignals_T_7 = mux(_csignals_T_3, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node csignals_3 = mux(_csignals_T_1, UInt<1>("h1"), _csignals_T_7) @[Lookup.scala 34:39]
    node _csignals_T_8 = mux(_csignals_T_3, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node csignals_4 = mux(_csignals_T_1, UInt<1>("h0"), _csignals_T_8) @[Lookup.scala 34:39]
    node _csignals_T_9 = mux(_csignals_T_3, UInt<3>("h1"), UInt<3>("h0")) @[Lookup.scala 34:39]
    node csignals_5 = mux(_csignals_T_1, UInt<3>("h0"), _csignals_T_9) @[Lookup.scala 34:39]
    node _csignals_T_10 = mux(_csignals_T_3, UInt<3>("h0"), UInt<3>("h0")) @[Lookup.scala 34:39]
    node csignals_6 = mux(_csignals_T_1, UInt<3>("h0"), _csignals_T_10) @[Lookup.scala 34:39]
    node _op1_data_T = eq(csignals_1, UInt<2>("h0")) @[Core.scala 50:18]
    node op1_data = mux(_op1_data_T, rs1_data, UInt<32>("h0")) @[Mux.scala 101:16]
    node _op2_data_T = eq(csignals_2, UInt<2>("h1")) @[Core.scala 55:22]
    node _op2_data_T_1 = eq(csignals_2, UInt<2>("h3")) @[Core.scala 56:22]
    node _op2_data_T_2 = eq(csignals_2, UInt<2>("h2")) @[Core.scala 57:22]
    node _op2_data_T_3 = mux(_op2_data_T_2, imm_i_sext, UInt<32>("h0")) @[Mux.scala 101:16]
    node _op2_data_T_4 = mux(_op2_data_T_1, imm_s_sext, _op2_data_T_3) @[Mux.scala 101:16]
    node op2_data = mux(_op2_data_T, rs2_data, _op2_data_T_4) @[Mux.scala 101:16]
    node _alu_out_T = eq(csignals_0, UInt<5>("h1")) @[Core.scala 64:22]
    node _alu_out_T_1 = add(op1_data, op2_data) @[Core.scala 64:48]
    node _alu_out_T_2 = tail(_alu_out_T_1, 1) @[Core.scala 64:48]
    node alu_out = mux(_alu_out_T, _alu_out_T_2, UInt<32>("h0")) @[Mux.scala 101:16]
    node _T = eq(csignals_3, UInt<1>("h1")) @[Core.scala 69:18]
    node _GEN_0 = mux(_T, csignals_3, io_dmem_wen_REG) @[Core.scala 20:17 69:28 70:21]
    node _GEN_1 = mux(_T, alu_out, io_dmem_addr_REG) @[Core.scala 21:18 69:28 71:21]
    node _GEN_2 = mux(_T, rs2_data, io_dmem_wdata_REG) @[Core.scala 19:19 69:28 72:23]
    node _T_1 = eq(csignals_5, UInt<3>("h1")) @[Core.scala 76:17]
    node _T_2 = eq(csignals_4, UInt<1>("h1")) @[Core.scala 76:38]
    node _T_3 = and(_T_1, _T_2) @[Core.scala 76:28]
    node _GEN_3 = mux(_T_3, alu_out, _GEN_1) @[Core.scala 76:48 77:22]
    node _GEN_4 = validif(_T_3, wb_addr) @[Core.scala 76:48 78:16]
    node _GEN_5 = validif(_T_3, clock) @[Core.scala 76:48 78:16]
    node _GEN_6 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[Core.scala 76:48 78:16 15:22]
    node _GEN_7 = validif(_T_3, UInt<1>("h1")) @[Core.scala 76:48 78:26]
    node _GEN_8 = validif(_T_3, io_dmem_rdata) @[Core.scala 76:48 78:26]
    node _io_exit_T = eq(io_imem_inst, UInt<32>("h5872e24d")) @[Core.scala 86:22]
    node _T_4 = asUInt(reset) @[Core.scala 94:9]
    node _T_5 = eq(_T_4, UInt<1>("h0")) @[Core.scala 94:9]
    node _T_6 = asUInt(reset) @[Core.scala 95:9]
    node _T_7 = eq(_T_6, UInt<1>("h0")) @[Core.scala 95:9]
    node _T_8 = asUInt(reset) @[Core.scala 96:9]
    node _T_9 = eq(_T_8, UInt<1>("h0")) @[Core.scala 96:9]
    node _T_10 = asUInt(reset) @[Core.scala 97:9]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[Core.scala 97:9]
    node _T_12 = asUInt(reset) @[Core.scala 98:9]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[Core.scala 98:9]
    node _T_14 = asUInt(reset) @[Core.scala 99:9]
    node _T_15 = eq(_T_14, UInt<1>("h0")) @[Core.scala 99:9]
    node _T_16 = asUInt(reset) @[Core.scala 100:9]
    node _T_17 = eq(_T_16, UInt<1>("h0")) @[Core.scala 100:9]
    node _T_18 = asUInt(reset) @[Core.scala 101:9]
    node _T_19 = eq(_T_18, UInt<1>("h0")) @[Core.scala 101:9]
    node _T_20 = asUInt(reset) @[Core.scala 102:9]
    node _T_21 = eq(_T_20, UInt<1>("h0")) @[Core.scala 102:9]
    node _T_22 = asUInt(reset) @[Core.scala 104:9]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[Core.scala 104:9]
    node _T_24 = asUInt(reset) @[Core.scala 105:9]
    node _T_25 = eq(_T_24, UInt<1>("h0")) @[Core.scala 105:9]
    node _T_26 = asUInt(reset) @[Core.scala 106:9]
    node _T_27 = eq(_T_26, UInt<1>("h0")) @[Core.scala 106:9]
    node _T_28 = asUInt(reset) @[Core.scala 107:9]
    node _T_29 = eq(_T_28, UInt<1>("h0")) @[Core.scala 107:9]
    node _T_30 = asUInt(reset) @[Core.scala 108:9]
    node _T_31 = eq(_T_30, UInt<1>("h0")) @[Core.scala 108:9]
    node _T_32 = asUInt(reset) @[Core.scala 109:9]
    node _T_33 = eq(_T_32, UInt<1>("h0")) @[Core.scala 109:9]
    node _T_34 = asUInt(reset) @[Core.scala 110:9]
    node _T_35 = eq(_T_34, UInt<1>("h0")) @[Core.scala 110:9]
    node _T_36 = asUInt(reset) @[Core.scala 111:9]
    node _T_37 = eq(_T_36, UInt<1>("h0")) @[Core.scala 111:9]
    node _T_38 = asUInt(reset) @[Core.scala 112:9]
    node _T_39 = eq(_T_38, UInt<1>("h0")) @[Core.scala 112:9]
    node _T_40 = asUInt(reset) @[Core.scala 113:9]
    node _T_41 = eq(_T_40, UInt<1>("h0")) @[Core.scala 113:9]
    node _T_42 = asUInt(reset) @[Core.scala 114:9]
    node _T_43 = eq(_T_42, UInt<1>("h0")) @[Core.scala 114:9]
    io_dmem_addr <= _GEN_3
    io_dmem_wen <= _GEN_0
    io_dmem_wdata <= _GEN_2
    io_imem_addr <= pc_reg @[Core.scala 25:18]
    io_exit <= _io_exit_T @[Core.scala 86:13]
    regfile.rs1_data_MPORT.addr <= rs1_addr @[Core.scala 31:62]
    regfile.rs1_data_MPORT.en <= UInt<1>("h1") @[Core.scala 31:62]
    regfile.rs1_data_MPORT.clk <= clock @[Core.scala 31:62]
    regfile.rs2_data_MPORT.addr <= rs2_addr @[Core.scala 32:62]
    regfile.rs2_data_MPORT.en <= UInt<1>("h1") @[Core.scala 32:62]
    regfile.rs2_data_MPORT.clk <= clock @[Core.scala 32:62]
    regfile.MPORT.addr <= _GEN_4
    regfile.MPORT.en <= _GEN_6
    regfile.MPORT.clk <= _GEN_5
    regfile.MPORT.data <= _GEN_8
    regfile.MPORT.mask <= _GEN_7
    pc_reg <= mux(reset, UInt<32>("h0"), _pc_reg_T_1) @[Core.scala 18:{25,25} 23:13]
    io_dmem_wdata_REG <= mux(reset, UInt<32>("h0"), io_dmem_wdata_REG) @[Core.scala 19:{29,29,29}]
    io_dmem_wen_REG <= mux(reset, UInt<1>("h0"), io_dmem_wen_REG) @[Core.scala 20:{27,27,27}]
    io_dmem_addr_REG <= mux(reset, UInt<32>("h0"), io_dmem_addr_REG) @[Core.scala 21:{28,28,28}]
    printf(clock, and(and(UInt<1>("h1"), _T_5), UInt<1>("h1")), "pc_reg     : 0x%x\n", pc_reg) : printf @[Core.scala 94:9]
    printf(clock, and(and(UInt<1>("h1"), _T_7), UInt<1>("h1")), "inst       : 0x%x\n", io_imem_inst) : printf_1 @[Core.scala 95:9]
    printf(clock, and(and(UInt<1>("h1"), _T_9), UInt<1>("h1")), "===LW===\n") : printf_2 @[Core.scala 96:9]
    printf(clock, and(and(UInt<1>("h1"), _T_11), UInt<1>("h1")), "rs1_addr (addr of regfile for \"mem addr\"): %d\t", rs1_addr) : printf_3 @[Core.scala 97:9]
    printf(clock, and(and(UInt<1>("h1"), _T_13), UInt<1>("h1")), "rs1_data (\"addr for mem\"): 0x%x\n", rs1_data) : printf_4 @[Core.scala 98:9]
    printf(clock, and(and(UInt<1>("h1"), _T_15), UInt<1>("h1")), "imm_i: %d\t", imm_i) : printf_5 @[Core.scala 99:9]
    printf(clock, and(and(UInt<1>("h1"), _T_17), UInt<1>("h1")), "imm_i_sext: %d\n", imm_i_sext) : printf_6 @[Core.scala 100:9]
    printf(clock, and(and(UInt<1>("h1"), _T_19), UInt<1>("h1")), "rd/wb_addr (addr of regfile for mem date)   : %d\n", wb_addr) : printf_7 @[Core.scala 101:9]
    printf(clock, and(and(UInt<1>("h1"), _T_21), UInt<1>("h1")), " (load mem data)  : 0x%x\n", io_dmem_rdata) : printf_8 @[Core.scala 102:9]
    printf(clock, and(and(UInt<1>("h1"), _T_23), UInt<1>("h1")), "===SW===\n") : printf_9 @[Core.scala 104:9]
    printf(clock, and(and(UInt<1>("h1"), _T_25), UInt<1>("h1")), "save mem addr pointer (rs1_addr)   : %d\t", rs1_addr) : printf_10 @[Core.scala 105:9]
    printf(clock, and(and(UInt<1>("h1"), _T_27), UInt<1>("h1")), "save mem addr (rs1_data): 0x%x\n", rs1_data) : printf_11 @[Core.scala 106:9]
    printf(clock, and(and(UInt<1>("h1"), _T_29), UInt<1>("h1")), "imm_s  : %d\t", imm_s) : printf_12 @[Core.scala 107:9]
    printf(clock, and(and(UInt<1>("h1"), _T_31), UInt<1>("h1")), "imm_s_sext  : %d\n", imm_s_sext) : printf_13 @[Core.scala 108:9]
    printf(clock, and(and(UInt<1>("h1"), _T_33), UInt<1>("h1")), "save mem data ponter (rs2_addr)   : %d\t", rs2_addr) : printf_14 @[Core.scala 109:9]
    printf(clock, and(and(UInt<1>("h1"), _T_35), UInt<1>("h1")), "save mem data (rs2_data): 0x%x\n", rs2_data) : printf_15 @[Core.scala 110:9]
    printf(clock, and(and(UInt<1>("h1"), _T_37), UInt<1>("h1")), "dmem.addr  : %d\n", io_dmem_addr) : printf_16 @[Core.scala 111:9]
    printf(clock, and(and(UInt<1>("h1"), _T_39), UInt<1>("h1")), "dmem.wen   : %d\n", io_dmem_wen) : printf_17 @[Core.scala 112:9]
    printf(clock, and(and(UInt<1>("h1"), _T_41), UInt<1>("h1")), "dmem.wdata : 0x%x\n", io_dmem_wdata) : printf_18 @[Core.scala 113:9]
    printf(clock, and(and(UInt<1>("h1"), _T_43), UInt<1>("h1")), "---------\n") : printf_19 @[Core.scala 114:9]

  module Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_imem_addr : UInt<32>
    output io_imem_inst : UInt<32>
    input io_dmem_addr : UInt<32>
    output io_dmem_rdata : UInt<32>
    input io_dmem_wen : UInt<1>
    input io_dmem_wdata : UInt<32>

    mem mem : @[Memory.scala 25:18]
      data-type => UInt<8>
      depth => 16384
      read-latency => 0
      write-latency => 1
      reader => io_imem_inst_MPORT
      reader => io_imem_inst_MPORT_1
      reader => io_imem_inst_MPORT_2
      reader => io_imem_inst_MPORT_3
      reader => io_dmem_rdata_MPORT
      reader => io_dmem_rdata_MPORT_1
      reader => io_dmem_rdata_MPORT_2
      reader => io_dmem_rdata_MPORT_3
      writer => MPORT
      writer => MPORT_1
      writer => MPORT_2
      writer => MPORT_3
      read-under-write => undefined
    node _io_imem_inst_T = add(io_imem_addr, UInt<32>("h3")) @[Memory.scala 30:22]
    node _io_imem_inst_T_1 = tail(_io_imem_inst_T, 1) @[Memory.scala 30:22]
    node _io_imem_inst_T_2 = bits(_io_imem_inst_T_1, 13, 0) @[Memory.scala 30:8]
    node _io_imem_inst_T_3 = add(io_imem_addr, UInt<32>("h2")) @[Memory.scala 31:22]
    node _io_imem_inst_T_4 = tail(_io_imem_inst_T_3, 1) @[Memory.scala 31:22]
    node _io_imem_inst_T_5 = bits(_io_imem_inst_T_4, 13, 0) @[Memory.scala 31:8]
    node _io_imem_inst_T_6 = add(io_imem_addr, UInt<32>("h1")) @[Memory.scala 32:22]
    node _io_imem_inst_T_7 = tail(_io_imem_inst_T_6, 1) @[Memory.scala 32:22]
    node _io_imem_inst_T_8 = bits(_io_imem_inst_T_7, 13, 0) @[Memory.scala 32:8]
    node _io_imem_inst_T_9 = bits(io_imem_addr, 13, 0) @[Memory.scala 33:8]
    node io_imem_inst_lo = cat(mem.io_imem_inst_MPORT_2.data, mem.io_imem_inst_MPORT_3.data) @[Cat.scala 31:58]
    node io_imem_inst_hi = cat(mem.io_imem_inst_MPORT.data, mem.io_imem_inst_MPORT_1.data) @[Cat.scala 31:58]
    node _io_imem_inst_T_10 = cat(io_imem_inst_hi, io_imem_inst_lo) @[Cat.scala 31:58]
    node _io_dmem_rdata_T = add(io_dmem_addr, UInt<32>("h3")) @[Memory.scala 36:22]
    node _io_dmem_rdata_T_1 = tail(_io_dmem_rdata_T, 1) @[Memory.scala 36:22]
    node _io_dmem_rdata_T_2 = bits(_io_dmem_rdata_T_1, 13, 0) @[Memory.scala 36:8]
    node _io_dmem_rdata_T_3 = add(io_dmem_addr, UInt<32>("h2")) @[Memory.scala 37:22]
    node _io_dmem_rdata_T_4 = tail(_io_dmem_rdata_T_3, 1) @[Memory.scala 37:22]
    node _io_dmem_rdata_T_5 = bits(_io_dmem_rdata_T_4, 13, 0) @[Memory.scala 37:8]
    node _io_dmem_rdata_T_6 = add(io_dmem_addr, UInt<32>("h1")) @[Memory.scala 38:22]
    node _io_dmem_rdata_T_7 = tail(_io_dmem_rdata_T_6, 1) @[Memory.scala 38:22]
    node _io_dmem_rdata_T_8 = bits(_io_dmem_rdata_T_7, 13, 0) @[Memory.scala 38:8]
    node _io_dmem_rdata_T_9 = bits(io_dmem_addr, 13, 0) @[Memory.scala 39:8]
    node io_dmem_rdata_lo = cat(mem.io_dmem_rdata_MPORT_2.data, mem.io_dmem_rdata_MPORT_3.data) @[Cat.scala 31:58]
    node io_dmem_rdata_hi = cat(mem.io_dmem_rdata_MPORT.data, mem.io_dmem_rdata_MPORT_1.data) @[Cat.scala 31:58]
    node _io_dmem_rdata_T_10 = cat(io_dmem_rdata_hi, io_dmem_rdata_lo) @[Cat.scala 31:58]
    node _T = bits(io_dmem_addr, 13, 0) @[Memory.scala 43:8]
    node _T_1 = bits(io_dmem_wdata, 7, 0) @[Memory.scala 43:39]
    node _T_2 = add(io_dmem_addr, UInt<1>("h1")) @[Memory.scala 44:21]
    node _T_3 = tail(_T_2, 1) @[Memory.scala 44:21]
    node _T_4 = bits(_T_3, 13, 0) @[Memory.scala 44:8]
    node _T_5 = bits(io_dmem_wdata, 15, 8) @[Memory.scala 44:43]
    node _T_6 = add(io_dmem_addr, UInt<2>("h2")) @[Memory.scala 45:21]
    node _T_7 = tail(_T_6, 1) @[Memory.scala 45:21]
    node _T_8 = bits(_T_7, 13, 0) @[Memory.scala 45:8]
    node _T_9 = bits(io_dmem_wdata, 23, 16) @[Memory.scala 45:43]
    node _T_10 = add(io_dmem_addr, UInt<2>("h3")) @[Memory.scala 46:21]
    node _T_11 = tail(_T_10, 1) @[Memory.scala 46:21]
    node _T_12 = bits(_T_11, 13, 0) @[Memory.scala 46:8]
    node _T_13 = bits(io_dmem_wdata, 31, 24) @[Memory.scala 46:43]
    node _GEN_0 = validif(io_dmem_wen, _T) @[Memory.scala 42:21 43:8]
    node _GEN_1 = validif(io_dmem_wen, clock) @[Memory.scala 42:21 43:8]
    node _GEN_2 = mux(io_dmem_wen, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 25:18 42:21 43:8]
    node _GEN_3 = validif(io_dmem_wen, UInt<1>("h1")) @[Memory.scala 42:21 43:23]
    node _GEN_4 = validif(io_dmem_wen, _T_1) @[Memory.scala 42:21 43:23]
    node _GEN_5 = validif(io_dmem_wen, _T_4) @[Memory.scala 42:21 44:8]
    node _GEN_6 = validif(io_dmem_wen, _T_5) @[Memory.scala 42:21 44:27]
    node _GEN_7 = validif(io_dmem_wen, _T_8) @[Memory.scala 42:21 45:8]
    node _GEN_8 = validif(io_dmem_wen, _T_9) @[Memory.scala 42:21 45:27]
    node _GEN_9 = validif(io_dmem_wen, _T_12) @[Memory.scala 42:21 46:8]
    node _GEN_10 = validif(io_dmem_wen, _T_13) @[Memory.scala 42:21 46:27]
    io_imem_inst <= _io_imem_inst_T_10 @[Memory.scala 29:18]
    io_dmem_rdata <= _io_dmem_rdata_T_10 @[Memory.scala 35:18]
    mem.io_imem_inst_MPORT.addr <= _io_imem_inst_T_2 @[Memory.scala 30:8]
    mem.io_imem_inst_MPORT.en <= UInt<1>("h1") @[Memory.scala 30:8]
    mem.io_imem_inst_MPORT.clk <= clock @[Memory.scala 30:8]
    mem.io_imem_inst_MPORT_1.addr <= _io_imem_inst_T_5 @[Memory.scala 31:8]
    mem.io_imem_inst_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 31:8]
    mem.io_imem_inst_MPORT_1.clk <= clock @[Memory.scala 31:8]
    mem.io_imem_inst_MPORT_2.addr <= _io_imem_inst_T_8 @[Memory.scala 32:8]
    mem.io_imem_inst_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 32:8]
    mem.io_imem_inst_MPORT_2.clk <= clock @[Memory.scala 32:8]
    mem.io_imem_inst_MPORT_3.addr <= _io_imem_inst_T_9 @[Memory.scala 33:8]
    mem.io_imem_inst_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 33:8]
    mem.io_imem_inst_MPORT_3.clk <= clock @[Memory.scala 33:8]
    mem.io_dmem_rdata_MPORT.addr <= _io_dmem_rdata_T_2 @[Memory.scala 36:8]
    mem.io_dmem_rdata_MPORT.en <= UInt<1>("h1") @[Memory.scala 36:8]
    mem.io_dmem_rdata_MPORT.clk <= clock @[Memory.scala 36:8]
    mem.io_dmem_rdata_MPORT_1.addr <= _io_dmem_rdata_T_5 @[Memory.scala 37:8]
    mem.io_dmem_rdata_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 37:8]
    mem.io_dmem_rdata_MPORT_1.clk <= clock @[Memory.scala 37:8]
    mem.io_dmem_rdata_MPORT_2.addr <= _io_dmem_rdata_T_8 @[Memory.scala 38:8]
    mem.io_dmem_rdata_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 38:8]
    mem.io_dmem_rdata_MPORT_2.clk <= clock @[Memory.scala 38:8]
    mem.io_dmem_rdata_MPORT_3.addr <= _io_dmem_rdata_T_9 @[Memory.scala 39:8]
    mem.io_dmem_rdata_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 39:8]
    mem.io_dmem_rdata_MPORT_3.clk <= clock @[Memory.scala 39:8]
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3
    mem.MPORT_1.addr <= _GEN_5
    mem.MPORT_1.en <= _GEN_2
    mem.MPORT_1.clk <= _GEN_1
    mem.MPORT_1.data <= _GEN_6
    mem.MPORT_1.mask <= _GEN_3
    mem.MPORT_2.addr <= _GEN_7
    mem.MPORT_2.en <= _GEN_2
    mem.MPORT_2.clk <= _GEN_1
    mem.MPORT_2.data <= _GEN_8
    mem.MPORT_2.mask <= _GEN_3
    mem.MPORT_3.addr <= _GEN_9
    mem.MPORT_3.en <= _GEN_2
    mem.MPORT_3.clk <= _GEN_1
    mem.MPORT_3.data <= _GEN_10
    mem.MPORT_3.mask <= _GEN_3

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_exit : UInt<1>

    inst core of Core @[Top.scala 12:20]
    inst memory of Memory @[Top.scala 13:22]
    io_exit <= core.io_exit @[Top.scala 16:11]
    core.clock <= clock
    core.reset <= reset
    core.io_dmem_rdata <= memory.io_dmem_rdata @[Top.scala 15:16]
    core.io_imem_inst <= memory.io_imem_inst @[Top.scala 14:16]
    memory.clock <= clock
    memory.reset <= reset
    memory.io_imem_addr <= core.io_imem_addr @[Top.scala 14:16]
    memory.io_dmem_addr <= core.io_dmem_addr @[Top.scala 15:16]
    memory.io_dmem_wen <= core.io_dmem_wen @[Top.scala 15:16]
    memory.io_dmem_wdata <= core.io_dmem_wdata @[Top.scala 15:16]

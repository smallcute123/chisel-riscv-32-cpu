circuit Top :
  module Core :
    input clock : Clock
    input reset : Reset
    output io : { flip imem : { flip addr : UInt<32>, inst : UInt<32>}, exit : UInt<1>}

    cmem regfile : UInt<32> [32] @[Core.scala 12:22]
    reg pc_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Core.scala 15:25]
    node _pc_reg_T = eq(io.imem.inst, UInt<32>("h0")) @[Core.scala 18:33]
    node _pc_reg_T_1 = add(pc_reg, UInt<32>("h4")) @[Core.scala 19:26]
    node _pc_reg_T_2 = tail(_pc_reg_T_1, 1) @[Core.scala 19:26]
    node _pc_reg_T_3 = mux(_pc_reg_T, pc_reg, _pc_reg_T_2) @[Core.scala 18:18]
    pc_reg <= _pc_reg_T_3 @[Core.scala 18:12]
    io.imem.addr <= pc_reg @[Core.scala 20:18]
    node _io_exit_T = eq(io.imem.inst, UInt<32>("h5872e24d")) @[Core.scala 24:22]
    io.exit <= _io_exit_T @[Core.scala 24:13]
    node _T = asUInt(reset) @[Core.scala 25:11]
    node _T_1 = eq(_T, UInt<1>("h0")) @[Core.scala 25:11]
    when _T_1 : @[Core.scala 25:11]
      printf(clock, UInt<1>("h1"), "pc_reg : 0x%x\n", pc_reg) : printf @[Core.scala 25:11]
    node _T_2 = asUInt(reset) @[Core.scala 28:11]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[Core.scala 28:11]
    when _T_3 : @[Core.scala 28:11]
      printf(clock, UInt<1>("h1"), "inst : 0x%x\n", io.imem.inst) : printf_1 @[Core.scala 28:11]
    node _T_4 = asUInt(reset) @[Core.scala 29:11]
    node _T_5 = eq(_T_4, UInt<1>("h0")) @[Core.scala 29:11]
    when _T_5 : @[Core.scala 29:11]
      printf(clock, UInt<1>("h1"), "--------\n") : printf_2 @[Core.scala 29:11]

  module Memory :
    input clock : Clock
    input reset : Reset
    output io : { imem : { flip addr : UInt<32>, inst : UInt<32>}}

    cmem mem : UInt<8> [16384] @[Memory.scala 17:18]
    node _io_imem_inst_T = add(io.imem.addr, UInt<32>("h3")) @[Memory.scala 21:22]
    node _io_imem_inst_T_1 = tail(_io_imem_inst_T, 1) @[Memory.scala 21:22]
    node _io_imem_inst_T_2 = bits(_io_imem_inst_T_1, 13, 0) @[Memory.scala 21:8]
    infer mport io_imem_inst_MPORT = mem[_io_imem_inst_T_2], clock @[Memory.scala 21:8]
    node _io_imem_inst_T_3 = add(io.imem.addr, UInt<32>("h2")) @[Memory.scala 22:22]
    node _io_imem_inst_T_4 = tail(_io_imem_inst_T_3, 1) @[Memory.scala 22:22]
    node _io_imem_inst_T_5 = bits(_io_imem_inst_T_4, 13, 0) @[Memory.scala 22:8]
    infer mport io_imem_inst_MPORT_1 = mem[_io_imem_inst_T_5], clock @[Memory.scala 22:8]
    node _io_imem_inst_T_6 = add(io.imem.addr, UInt<32>("h1")) @[Memory.scala 23:22]
    node _io_imem_inst_T_7 = tail(_io_imem_inst_T_6, 1) @[Memory.scala 23:22]
    node _io_imem_inst_T_8 = bits(_io_imem_inst_T_7, 13, 0) @[Memory.scala 23:8]
    infer mport io_imem_inst_MPORT_2 = mem[_io_imem_inst_T_8], clock @[Memory.scala 23:8]
    node _io_imem_inst_T_9 = bits(io.imem.addr, 13, 0) @[Memory.scala 24:8]
    infer mport io_imem_inst_MPORT_3 = mem[_io_imem_inst_T_9], clock @[Memory.scala 24:8]
    node io_imem_inst_lo = cat(io_imem_inst_MPORT_2, io_imem_inst_MPORT_3) @[Cat.scala 31:58]
    node io_imem_inst_hi = cat(io_imem_inst_MPORT, io_imem_inst_MPORT_1) @[Cat.scala 31:58]
    node _io_imem_inst_T_10 = cat(io_imem_inst_hi, io_imem_inst_lo) @[Cat.scala 31:58]
    io.imem.inst <= _io_imem_inst_T_10 @[Memory.scala 20:18]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { exit : UInt<1>}

    inst core of Core @[Top.scala 10:20]
    core.clock <= clock
    core.reset <= reset
    inst memory of Memory @[Top.scala 11:22]
    memory.clock <= clock
    memory.reset <= reset
    core.io.imem.inst <= memory.io.imem.inst @[Top.scala 12:16]
    memory.io.imem.addr <= core.io.imem.addr @[Top.scala 12:16]
    io.exit <= core.io.exit @[Top.scala 13:11]


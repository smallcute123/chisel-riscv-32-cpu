circuit Core :
  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip imem : { flip addr : UInt<32>, inst : UInt<32>}, exit : UInt<1>}

    cmem regfile : UInt<32> [32] @[Core.scala 12:22]
    reg pc_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Core.scala 15:25]
    node _pc_reg_T = add(pc_reg, UInt<32>("h4")) @[Core.scala 17:23]
    node _pc_reg_T_1 = tail(_pc_reg_T, 1) @[Core.scala 17:23]
    pc_reg <= _pc_reg_T_1 @[Core.scala 17:13]
    io.imem.addr <= pc_reg @[Core.scala 18:18]
    node _io_exit_T = eq(io.imem.inst, UInt<32>("h5872e24d")) @[Core.scala 22:22]
    io.exit <= _io_exit_T @[Core.scala 22:13]
    node _T = bits(reset, 0, 0) @[Core.scala 23:11]
    node _T_1 = eq(_T, UInt<1>("h0")) @[Core.scala 23:11]
    when _T_1 : @[Core.scala 23:11]
      printf(clock, UInt<1>("h1"), "pc_reg : 0x%x\n", pc_reg) : printf @[Core.scala 23:11]
    node _T_2 = bits(reset, 0, 0) @[Core.scala 26:11]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[Core.scala 26:11]
    when _T_3 : @[Core.scala 26:11]
      printf(clock, UInt<1>("h1"), "inst : 0x%x\n", io.imem.inst) : printf_1 @[Core.scala 26:11]
    node _T_4 = bits(reset, 0, 0) @[Core.scala 27:11]
    node _T_5 = eq(_T_4, UInt<1>("h0")) @[Core.scala 27:11]
    when _T_5 : @[Core.scala 27:11]
      printf(clock, UInt<1>("h1"), "--------\n") : printf_2 @[Core.scala 27:11]


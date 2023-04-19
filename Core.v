module Core(
  input         clock,
  input         reset,
  output [31:0] io_dmem_addr,
  input  [31:0] io_dmem_rdata,
  output        io_dmem_wen,
  output [31:0] io_dmem_wdata,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_inst,
  output        io_exit
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[Core.scala 15:22]
  wire  regfile_rs1_data_MPORT_en; // @[Core.scala 15:22]
  wire [4:0] regfile_rs1_data_MPORT_addr; // @[Core.scala 15:22]
  wire [31:0] regfile_rs1_data_MPORT_data; // @[Core.scala 15:22]
  wire  regfile_rs2_data_MPORT_en; // @[Core.scala 15:22]
  wire [4:0] regfile_rs2_data_MPORT_addr; // @[Core.scala 15:22]
  wire [31:0] regfile_rs2_data_MPORT_data; // @[Core.scala 15:22]
  wire [31:0] regfile_MPORT_data; // @[Core.scala 15:22]
  wire [4:0] regfile_MPORT_addr; // @[Core.scala 15:22]
  wire  regfile_MPORT_mask; // @[Core.scala 15:22]
  wire  regfile_MPORT_en; // @[Core.scala 15:22]
  reg [31:0] pc_reg; // @[Core.scala 18:25]
  wire [31:0] _pc_next_T_1 = pc_reg + 32'h4; // @[Core.scala 30:33]
  wire [31:0] _pc_next_T_2 = io_imem_inst & 32'h7f; // @[Core.scala 33:15]
  wire  _pc_next_T_3 = 32'h6f == _pc_next_T_2; // @[Core.scala 33:15]
  wire [31:0] _pc_next_T_4 = io_imem_inst & 32'h707f; // @[Core.scala 33:29]
  wire  _pc_next_T_5 = 32'h67 == _pc_next_T_4; // @[Core.scala 33:29]
  wire  _pc_next_T_6 = 32'h6f == _pc_next_T_2 | 32'h67 == _pc_next_T_4; // @[Core.scala 33:22]
  wire  csignals_3 = 32'h2023 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h2003 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_4 = io_imem_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h33 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h13 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h40000033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h7033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h6033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h4033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h7013 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h6013 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h4013 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h1033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h5033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h40005033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h1013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h5013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h40005013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h2033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_37 = 32'h3033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_39 = 32'h2013 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_41 = 32'h3013 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_45 = 32'h37 == _pc_next_T_2; // @[Lookup.scala 31:38]
  wire  _csignals_T_47 = 32'h17 == _pc_next_T_2; // @[Lookup.scala 31:38]
  wire  _csignals_T_51 = 32'h63 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_53 = 32'h1063 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_55 = 32'h5063 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_57 = 32'h7063 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_59 = 32'h4063 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_61 = 32'h6063 == _pc_next_T_4; // @[Lookup.scala 31:38]
  wire [4:0] _csignals_T_62 = _csignals_T_61 ? 5'hf : 5'h0; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_63 = _csignals_T_59 ? 5'hd : _csignals_T_62; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_64 = _csignals_T_57 ? 5'h10 : _csignals_T_63; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_65 = _csignals_T_55 ? 5'he : _csignals_T_64; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_66 = _csignals_T_53 ? 5'hc : _csignals_T_65; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_67 = _csignals_T_51 ? 5'hb : _csignals_T_66; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_68 = _pc_next_T_5 ? 5'h11 : _csignals_T_67; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_69 = _csignals_T_47 ? 5'h1 : _csignals_T_68; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_70 = _csignals_T_45 ? 5'h1 : _csignals_T_69; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_71 = _pc_next_T_3 ? 5'h1 : _csignals_T_70; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_72 = _csignals_T_41 ? 5'ha : _csignals_T_71; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_73 = _csignals_T_39 ? 5'h9 : _csignals_T_72; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_74 = _csignals_T_37 ? 5'ha : _csignals_T_73; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_75 = _csignals_T_35 ? 5'h9 : _csignals_T_74; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_76 = _csignals_T_33 ? 5'h8 : _csignals_T_75; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_77 = _csignals_T_31 ? 5'h7 : _csignals_T_76; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_78 = _csignals_T_29 ? 5'h6 : _csignals_T_77; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_79 = _csignals_T_27 ? 5'h8 : _csignals_T_78; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_80 = _csignals_T_25 ? 5'h7 : _csignals_T_79; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_81 = _csignals_T_23 ? 5'h6 : _csignals_T_80; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_82 = _csignals_T_21 ? 5'h5 : _csignals_T_81; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_83 = _csignals_T_19 ? 5'h4 : _csignals_T_82; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_84 = _csignals_T_17 ? 5'h3 : _csignals_T_83; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_85 = _csignals_T_15 ? 5'h5 : _csignals_T_84; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_86 = _csignals_T_13 ? 5'h4 : _csignals_T_85; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_87 = _csignals_T_11 ? 5'h3 : _csignals_T_86; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_88 = _csignals_T_9 ? 5'h2 : _csignals_T_87; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_89 = _csignals_T_7 ? 5'h1 : _csignals_T_88; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_90 = _csignals_T_5 ? 5'h1 : _csignals_T_89; // @[Lookup.scala 34:39]
  wire [4:0] _csignals_T_91 = _csignals_T_3 ? 5'h1 : _csignals_T_90; // @[Lookup.scala 34:39]
  wire [4:0] csignals_0 = csignals_3 ? 5'h1 : _csignals_T_91; // @[Lookup.scala 34:39]
  wire  _alu_out_T = csignals_0 == 5'h1; // @[Core.scala 122:22]
  wire [1:0] _csignals_T_92 = _csignals_T_61 ? 2'h0 : 2'h2; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_93 = _csignals_T_59 ? 2'h0 : _csignals_T_92; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_94 = _csignals_T_57 ? 2'h0 : _csignals_T_93; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_95 = _csignals_T_55 ? 2'h0 : _csignals_T_94; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_96 = _csignals_T_53 ? 2'h0 : _csignals_T_95; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_97 = _csignals_T_51 ? 2'h0 : _csignals_T_96; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_98 = _pc_next_T_5 ? 2'h1 : _csignals_T_97; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_99 = _csignals_T_47 ? 2'h1 : _csignals_T_98; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_100 = _csignals_T_45 ? 2'h2 : _csignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_101 = _pc_next_T_3 ? 2'h1 : _csignals_T_100; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_102 = _csignals_T_41 ? 2'h0 : _csignals_T_101; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_103 = _csignals_T_39 ? 2'h0 : _csignals_T_102; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_104 = _csignals_T_37 ? 2'h0 : _csignals_T_103; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_105 = _csignals_T_35 ? 2'h0 : _csignals_T_104; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_106 = _csignals_T_33 ? 2'h0 : _csignals_T_105; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_107 = _csignals_T_31 ? 2'h0 : _csignals_T_106; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_108 = _csignals_T_29 ? 2'h0 : _csignals_T_107; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_109 = _csignals_T_27 ? 2'h0 : _csignals_T_108; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_110 = _csignals_T_25 ? 2'h0 : _csignals_T_109; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_111 = _csignals_T_23 ? 2'h0 : _csignals_T_110; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_112 = _csignals_T_21 ? 2'h0 : _csignals_T_111; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_113 = _csignals_T_19 ? 2'h0 : _csignals_T_112; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_114 = _csignals_T_17 ? 2'h0 : _csignals_T_113; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_115 = _csignals_T_15 ? 2'h0 : _csignals_T_114; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_116 = _csignals_T_13 ? 2'h0 : _csignals_T_115; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_117 = _csignals_T_11 ? 2'h0 : _csignals_T_116; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_118 = _csignals_T_9 ? 2'h0 : _csignals_T_117; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_119 = _csignals_T_7 ? 2'h0 : _csignals_T_118; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_120 = _csignals_T_5 ? 2'h0 : _csignals_T_119; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_121 = _csignals_T_3 ? 2'h0 : _csignals_T_120; // @[Lookup.scala 34:39]
  wire [1:0] csignals_1 = csignals_3 ? 2'h0 : _csignals_T_121; // @[Lookup.scala 34:39]
  wire  _op1_data_T = csignals_1 == 2'h0; // @[Core.scala 103:18]
  wire [4:0] rs1_addr = io_imem_inst[19:15]; // @[Core.scala 42:24]
  wire [31:0] _GEN_5 = {{27'd0}, rs1_addr}; // @[Core.scala 44:34]
  wire [31:0] rs1_data = _GEN_5 != 32'h0 ? regfile_rs1_data_MPORT_data : 32'h0; // @[Core.scala 44:23]
  wire  _op1_data_T_1 = csignals_1 == 2'h1; // @[Core.scala 104:18]
  wire [31:0] _op1_data_T_2 = _op1_data_T_1 ? pc_reg : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] op1_data = _op1_data_T ? rs1_data : _op1_data_T_2; // @[Mux.scala 101:16]
  wire [2:0] _csignals_T_122 = _csignals_T_61 ? 3'h1 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_123 = _csignals_T_59 ? 3'h1 : _csignals_T_122; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_124 = _csignals_T_57 ? 3'h1 : _csignals_T_123; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_125 = _csignals_T_55 ? 3'h1 : _csignals_T_124; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_126 = _csignals_T_53 ? 3'h1 : _csignals_T_125; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_127 = _csignals_T_51 ? 3'h1 : _csignals_T_126; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_128 = _pc_next_T_5 ? 3'h2 : _csignals_T_127; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_129 = _csignals_T_47 ? 3'h5 : _csignals_T_128; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_130 = _csignals_T_45 ? 3'h5 : _csignals_T_129; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_131 = _pc_next_T_3 ? 3'h4 : _csignals_T_130; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_132 = _csignals_T_41 ? 3'h2 : _csignals_T_131; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_133 = _csignals_T_39 ? 3'h2 : _csignals_T_132; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_134 = _csignals_T_37 ? 3'h1 : _csignals_T_133; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_135 = _csignals_T_35 ? 3'h1 : _csignals_T_134; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_136 = _csignals_T_33 ? 3'h2 : _csignals_T_135; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_137 = _csignals_T_31 ? 3'h2 : _csignals_T_136; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_138 = _csignals_T_29 ? 3'h2 : _csignals_T_137; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_139 = _csignals_T_27 ? 3'h1 : _csignals_T_138; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_140 = _csignals_T_25 ? 3'h1 : _csignals_T_139; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_141 = _csignals_T_23 ? 3'h1 : _csignals_T_140; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_142 = _csignals_T_21 ? 3'h2 : _csignals_T_141; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_143 = _csignals_T_19 ? 3'h2 : _csignals_T_142; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_144 = _csignals_T_17 ? 3'h2 : _csignals_T_143; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_145 = _csignals_T_15 ? 3'h1 : _csignals_T_144; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_146 = _csignals_T_13 ? 3'h1 : _csignals_T_145; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_147 = _csignals_T_11 ? 3'h1 : _csignals_T_146; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_148 = _csignals_T_9 ? 3'h1 : _csignals_T_147; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_149 = _csignals_T_7 ? 3'h2 : _csignals_T_148; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_150 = _csignals_T_5 ? 3'h1 : _csignals_T_149; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_151 = _csignals_T_3 ? 3'h2 : _csignals_T_150; // @[Lookup.scala 34:39]
  wire [2:0] csignals_2 = csignals_3 ? 3'h3 : _csignals_T_151; // @[Lookup.scala 34:39]
  wire  _op2_data_T = csignals_2 == 3'h1; // @[Core.scala 110:22]
  wire [4:0] rs2_addr = io_imem_inst[24:20]; // @[Core.scala 43:24]
  wire [31:0] _GEN_6 = {{27'd0}, rs2_addr}; // @[Core.scala 45:34]
  wire [31:0] rs2_data = _GEN_6 != 32'h0 ? regfile_rs2_data_MPORT_data : 32'h0; // @[Core.scala 45:23]
  wire  _op2_data_T_1 = csignals_2 == 3'h3; // @[Core.scala 111:22]
  wire [11:0] imm_s = {io_imem_inst[31:25],io_imem_inst[11:7]}; // @[Cat.scala 31:58]
  wire [19:0] _imm_s_sext_T_2 = imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_s_sext = {_imm_s_sext_T_2,io_imem_inst[31:25],io_imem_inst[11:7]}; // @[Cat.scala 31:58]
  wire  _op2_data_T_2 = csignals_2 == 3'h2; // @[Core.scala 112:22]
  wire [11:0] imm_i = io_imem_inst[31:20]; // @[Core.scala 48:21]
  wire [19:0] _imm_i_sext_T_2 = imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_i_sext = {_imm_i_sext_T_2,imm_i}; // @[Cat.scala 31:58]
  wire  _op2_data_T_3 = csignals_2 == 3'h4; // @[Core.scala 113:22]
  wire [19:0] imm_j = {io_imem_inst[31],io_imem_inst[19:12],io_imem_inst[20],io_imem_inst[30:21]}; // @[Cat.scala 31:58]
  wire [10:0] _imm_j_sext_T_2 = imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_j_sext = {_imm_j_sext_T_2,io_imem_inst[31],io_imem_inst[19:12],io_imem_inst[20],io_imem_inst[30:21],1'h0
    }; // @[Cat.scala 31:58]
  wire  _op2_data_T_4 = csignals_2 == 3'h5; // @[Core.scala 114:22]
  wire [19:0] imm_u = io_imem_inst[31:12]; // @[Core.scala 53:25]
  wire [31:0] imm_u_sext = {imm_u,12'h0}; // @[Cat.scala 31:58]
  wire [31:0] _op2_data_T_5 = _op2_data_T_4 ? imm_u_sext : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_6 = _op2_data_T_3 ? imm_j_sext : _op2_data_T_5; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_7 = _op2_data_T_2 ? imm_i_sext : _op2_data_T_6; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_8 = _op2_data_T_1 ? imm_s_sext : _op2_data_T_7; // @[Mux.scala 101:16]
  wire [31:0] op2_data = _op2_data_T ? rs2_data : _op2_data_T_8; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_2 = op1_data + op2_data; // @[Core.scala 122:48]
  wire  _alu_out_T_3 = csignals_0 == 5'h2; // @[Core.scala 123:22]
  wire [31:0] _alu_out_T_5 = op1_data - op2_data; // @[Core.scala 123:48]
  wire  _alu_out_T_6 = csignals_0 == 5'h3; // @[Core.scala 124:22]
  wire [31:0] _alu_out_T_7 = op1_data & op2_data; // @[Core.scala 124:48]
  wire  _alu_out_T_8 = csignals_0 == 5'h4; // @[Core.scala 125:22]
  wire [31:0] _alu_out_T_9 = op1_data | op2_data; // @[Core.scala 125:48]
  wire  _alu_out_T_10 = csignals_0 == 5'h5; // @[Core.scala 126:22]
  wire [31:0] _alu_out_T_11 = op1_data ^ op2_data; // @[Core.scala 126:48]
  wire  _alu_out_T_12 = csignals_0 == 5'h6; // @[Core.scala 127:22]
  wire [62:0] _GEN_0 = {{31'd0}, op1_data}; // @[Core.scala 127:48]
  wire [62:0] _alu_out_T_14 = _GEN_0 << op2_data[4:0]; // @[Core.scala 127:48]
  wire  _alu_out_T_16 = csignals_0 == 5'h7; // @[Core.scala 128:22]
  wire [31:0] _alu_out_T_18 = op1_data >> op2_data[4:0]; // @[Core.scala 128:48]
  wire  _alu_out_T_19 = csignals_0 == 5'h8; // @[Core.scala 129:22]
  wire [31:0] _alu_out_T_20 = _op1_data_T ? rs1_data : _op1_data_T_2; // @[Core.scala 129:54]
  wire [31:0] _alu_out_T_23 = $signed(_alu_out_T_20) >>> op2_data[4:0]; // @[Core.scala 129:82]
  wire  _alu_out_T_24 = csignals_0 == 5'h9; // @[Core.scala 130:22]
  wire [31:0] _alu_out_T_26 = _op2_data_T ? rs2_data : _op2_data_T_8; // @[Core.scala 130:74]
  wire  _alu_out_T_27 = $signed(_alu_out_T_20) < $signed(_alu_out_T_26); // @[Core.scala 130:57]
  wire  _alu_out_T_28 = csignals_0 == 5'ha; // @[Core.scala 131:22]
  wire  _alu_out_T_29 = op1_data < op2_data; // @[Core.scala 131:49]
  wire  _alu_out_T_30 = csignals_0 == 5'h11; // @[Core.scala 132:22]
  wire [31:0] _alu_out_T_33 = _alu_out_T_2 & 32'hfffffffe; // @[Core.scala 132:60]
  wire [31:0] _alu_out_T_34 = _alu_out_T_30 ? _alu_out_T_33 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_35 = _alu_out_T_28 ? {{31'd0}, _alu_out_T_29} : _alu_out_T_34; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_36 = _alu_out_T_24 ? {{31'd0}, _alu_out_T_27} : _alu_out_T_35; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_37 = _alu_out_T_19 ? _alu_out_T_23 : _alu_out_T_36; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_38 = _alu_out_T_16 ? _alu_out_T_18 : _alu_out_T_37; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_39 = _alu_out_T_12 ? _alu_out_T_14[31:0] : _alu_out_T_38; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_40 = _alu_out_T_10 ? _alu_out_T_11 : _alu_out_T_39; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_41 = _alu_out_T_8 ? _alu_out_T_9 : _alu_out_T_40; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_42 = _alu_out_T_6 ? _alu_out_T_7 : _alu_out_T_41; // @[Mux.scala 101:16]
  wire [31:0] _alu_out_T_43 = _alu_out_T_3 ? _alu_out_T_5 : _alu_out_T_42; // @[Mux.scala 101:16]
  wire [31:0] alu_out = _alu_out_T ? _alu_out_T_2 : _alu_out_T_43; // @[Mux.scala 101:16]
  wire  _br_flag_T = csignals_0 == 5'hb; // @[Core.scala 139:22]
  wire  _br_flag_T_1 = op1_data == op2_data; // @[Core.scala 139:49]
  wire  _br_flag_T_2 = csignals_0 == 5'hc; // @[Core.scala 140:22]
  wire  _br_flag_T_4 = ~_br_flag_T_1; // @[Core.scala 140:38]
  wire  _br_flag_T_5 = csignals_0 == 5'hd; // @[Core.scala 141:22]
  wire  _br_flag_T_9 = csignals_0 == 5'he; // @[Core.scala 142:22]
  wire  _br_flag_T_13 = ~_alu_out_T_27; // @[Core.scala 142:38]
  wire  _br_flag_T_14 = csignals_0 == 5'hf; // @[Core.scala 143:22]
  wire  _br_flag_T_16 = csignals_0 == 5'h10; // @[Core.scala 144:22]
  wire  _br_flag_T_18 = ~_alu_out_T_29; // @[Core.scala 144:38]
  wire  _br_flag_T_20 = _br_flag_T_14 ? _alu_out_T_29 : _br_flag_T_16 & _br_flag_T_18; // @[Mux.scala 101:16]
  wire  _br_flag_T_21 = _br_flag_T_9 ? _br_flag_T_13 : _br_flag_T_20; // @[Mux.scala 101:16]
  wire  _br_flag_T_22 = _br_flag_T_5 ? _alu_out_T_27 : _br_flag_T_21; // @[Mux.scala 101:16]
  wire  _br_flag_T_23 = _br_flag_T_2 ? _br_flag_T_4 : _br_flag_T_22; // @[Mux.scala 101:16]
  wire  br_flag = _br_flag_T ? _br_flag_T_1 : _br_flag_T_23; // @[Mux.scala 101:16]
  wire [11:0] imm_b = {io_imem_inst[31],io_imem_inst[7],io_imem_inst[30:25],io_imem_inst[11:8]}; // @[Cat.scala 31:58]
  wire [18:0] _imm_b_sext_T_2 = imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_b_sext = {_imm_b_sext_T_2,io_imem_inst[31],io_imem_inst[7],io_imem_inst[30:25],io_imem_inst[11:8],1'h0
    }; // @[Cat.scala 31:58]
  wire [31:0] br_target = pc_reg + imm_b_sext; // @[Core.scala 146:25]
  wire  _csignals_T_211 = _csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (
    _csignals_T_13 | (_csignals_T_15 | (_csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23 | (
    _csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (
    _csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_pc_next_T_3 | (_csignals_T_45 | (_csignals_T_47 |
    _pc_next_T_5)))))))))))))))))))))); // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_218 = _pc_next_T_5 ? 3'h2 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_219 = _csignals_T_47 ? 3'h0 : _csignals_T_218; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_220 = _csignals_T_45 ? 3'h0 : _csignals_T_219; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_221 = _pc_next_T_3 ? 3'h2 : _csignals_T_220; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_222 = _csignals_T_41 ? 3'h0 : _csignals_T_221; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_223 = _csignals_T_39 ? 3'h0 : _csignals_T_222; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_224 = _csignals_T_37 ? 3'h0 : _csignals_T_223; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_225 = _csignals_T_35 ? 3'h0 : _csignals_T_224; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_226 = _csignals_T_33 ? 3'h0 : _csignals_T_225; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_227 = _csignals_T_31 ? 3'h0 : _csignals_T_226; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_228 = _csignals_T_29 ? 3'h0 : _csignals_T_227; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_229 = _csignals_T_27 ? 3'h0 : _csignals_T_228; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_230 = _csignals_T_25 ? 3'h0 : _csignals_T_229; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_231 = _csignals_T_23 ? 3'h0 : _csignals_T_230; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_232 = _csignals_T_21 ? 3'h0 : _csignals_T_231; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_233 = _csignals_T_19 ? 3'h0 : _csignals_T_232; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_234 = _csignals_T_17 ? 3'h0 : _csignals_T_233; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_235 = _csignals_T_15 ? 3'h0 : _csignals_T_234; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_236 = _csignals_T_13 ? 3'h0 : _csignals_T_235; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_237 = _csignals_T_11 ? 3'h0 : _csignals_T_236; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_238 = _csignals_T_9 ? 3'h0 : _csignals_T_237; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_239 = _csignals_T_7 ? 3'h0 : _csignals_T_238; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_240 = _csignals_T_5 ? 3'h0 : _csignals_T_239; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_241 = _csignals_T_3 ? 3'h1 : _csignals_T_240; // @[Lookup.scala 34:39]
  wire [2:0] csignals_5 = csignals_3 ? 3'h0 : _csignals_T_241; // @[Lookup.scala 34:39]
  wire  _wb_data_T = csignals_5 == 3'h1; // @[Core.scala 157:17]
  wire  _wb_data_T_1 = csignals_5 == 3'h2; // @[Core.scala 158:17]
  wire [31:0] _wb_data_T_4 = _wb_data_T_1 ? _pc_next_T_1 : alu_out; // @[Mux.scala 101:16]
  wire [31:0] wb_data = _wb_data_T ? io_dmem_rdata : _wb_data_T_4; // @[Mux.scala 101:16]
  wire  _T_2 = ~reset; // @[Core.scala 178:9]
  assign regfile_rs1_data_MPORT_en = 1'h1;
  assign regfile_rs1_data_MPORT_addr = io_imem_inst[19:15];
  assign regfile_rs1_data_MPORT_data = regfile[regfile_rs1_data_MPORT_addr]; // @[Core.scala 15:22]
  assign regfile_rs2_data_MPORT_en = 1'h1;
  assign regfile_rs2_data_MPORT_addr = io_imem_inst[24:20];
  assign regfile_rs2_data_MPORT_data = regfile[regfile_rs2_data_MPORT_addr]; // @[Core.scala 15:22]
  assign regfile_MPORT_data = _wb_data_T ? io_dmem_rdata : _wb_data_T_4;
  assign regfile_MPORT_addr = io_imem_inst[11:7];
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = csignals_3 ? 1'h0 : _csignals_T_211;
  assign io_dmem_addr = _alu_out_T ? _alu_out_T_2 : _alu_out_T_43; // @[Mux.scala 101:16]
  assign io_dmem_wen = 32'h2023 == _pc_next_T_4; // @[Lookup.scala 31:38]
  assign io_dmem_wdata = _GEN_6 != 32'h0 ? regfile_rs2_data_MPORT_data : 32'h0; // @[Core.scala 45:23]
  assign io_imem_addr = pc_reg; // @[Core.scala 26:18]
  assign io_exit = io_imem_inst == 32'h5872e24d; // @[Core.scala 38:22]
  always @(posedge clock) begin
    if (regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[Core.scala 15:22]
    end
    if (reset) begin // @[Core.scala 18:25]
      pc_reg <= 32'h0; // @[Core.scala 18:25]
    end else if (br_flag) begin // @[Mux.scala 101:16]
      pc_reg <= br_target;
    end else if (_pc_next_T_6) begin // @[Mux.scala 101:16]
      if (_alu_out_T) begin // @[Mux.scala 101:16]
        pc_reg <= _alu_out_T_2;
      end else begin
        pc_reg <= _alu_out_T_43;
      end
    end else begin
      pc_reg <= _pc_next_T_1;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"pc_reg     : 0x%x\n",pc_reg); // @[Core.scala 178:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"inst       : 0x%x\n",io_imem_inst); // @[Core.scala 179:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"===LW===\n"); // @[Core.scala 180:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"rs1_addr (addr of regfile for \"mem addr\"): %d\t",rs1_addr); // @[Core.scala 181:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"rs1_data (\"addr for mem\"): 0x%x\n",rs1_data); // @[Core.scala 182:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"imm_i: %d\t",imm_i); // @[Core.scala 183:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"imm_i_sext: %d\n",imm_i_sext); // @[Core.scala 184:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"rd/wb_addr (addr of regfile for mem date)   : %d\n",io_imem_inst[11:7]); // @[Core.scala 185:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002," (load mem data)  : 0x%x\n",wb_data); // @[Core.scala 186:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"===SW===\n"); // @[Core.scala 188:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"save mem addr pointer (rs1_addr)   : %d\t",rs1_addr); // @[Core.scala 189:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"save mem addr (rs1_data): 0x%x\n",rs1_data); // @[Core.scala 190:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"imm_s  : %d\t",imm_s); // @[Core.scala 191:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"imm_s_sext  : %d\n",imm_s_sext); // @[Core.scala 192:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"save mem data ponter (rs2_addr)   : %d\t",rs2_addr); // @[Core.scala 193:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"save mem data (rs2_data): 0x%x\n",rs2_data); // @[Core.scala 194:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"dmem.addr  : %d\n",io_dmem_addr); // @[Core.scala 195:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"dmem.wen   : %d\n",io_dmem_wen); // @[Core.scala 196:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"dmem.wdata : 0x%x\n",io_dmem_wdata); // @[Core.scala 197:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"---------\n"); // @[Core.scala 198:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  pc_reg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

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
  wire [31:0] _pc_reg_T_1 = pc_reg + 32'h4; // @[Core.scala 23:23]
  wire [4:0] rs1_addr = io_imem_inst[19:15]; // @[Core.scala 29:24]
  wire [4:0] rs2_addr = io_imem_inst[24:20]; // @[Core.scala 30:24]
  wire [31:0] _GEN_9 = {{27'd0}, rs1_addr}; // @[Core.scala 31:34]
  wire [31:0] rs1_data = _GEN_9 != 32'h0 ? regfile_rs1_data_MPORT_data : 32'h0; // @[Core.scala 31:23]
  wire [31:0] _GEN_10 = {{27'd0}, rs2_addr}; // @[Core.scala 32:34]
  wire [31:0] rs2_data = _GEN_10 != 32'h0 ? regfile_rs2_data_MPORT_data : 32'h0; // @[Core.scala 32:23]
  wire [11:0] imm_s = {io_imem_inst[31:25],io_imem_inst[11:7]}; // @[Cat.scala 31:58]
  wire [19:0] _imm_s_sext_T_2 = imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_s_sext = {_imm_s_sext_T_2,io_imem_inst[31:25],io_imem_inst[11:7]}; // @[Cat.scala 31:58]
  wire [11:0] imm_i = io_imem_inst[31:20]; // @[Core.scala 35:21]
  wire [19:0] _imm_i_sext_T_2 = imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_i_sext = {_imm_i_sext_T_2,imm_i}; // @[Cat.scala 31:58]
  wire [31:0] _csignals_T = io_imem_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  csignals_3 = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h2003 == _csignals_T; // @[Lookup.scala 31:38]
  wire [4:0] _csignals_T_4 = _csignals_T_3 ? 5'h1 : 5'h0; // @[Lookup.scala 34:39]
  wire [4:0] csignals_0 = csignals_3 ? 5'h1 : _csignals_T_4; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_5 = _csignals_T_3 ? 2'h0 : 2'h2; // @[Lookup.scala 34:39]
  wire [1:0] csignals_1 = csignals_3 ? 2'h0 : _csignals_T_5; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_6 = _csignals_T_3 ? 2'h2 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] csignals_2 = csignals_3 ? 2'h3 : _csignals_T_6; // @[Lookup.scala 34:39]
  wire  csignals_4 = csignals_3 ? 1'h0 : _csignals_T_3; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_9 = _csignals_T_3 ? 3'h1 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] csignals_5 = csignals_3 ? 3'h0 : _csignals_T_9; // @[Lookup.scala 34:39]
  wire  _op1_data_T = csignals_1 == 2'h0; // @[Core.scala 50:18]
  wire [31:0] op1_data = _op1_data_T ? rs1_data : 32'h0; // @[Mux.scala 101:16]
  wire  _op2_data_T = csignals_2 == 2'h1; // @[Core.scala 55:22]
  wire  _op2_data_T_1 = csignals_2 == 2'h3; // @[Core.scala 56:22]
  wire  _op2_data_T_2 = csignals_2 == 2'h2; // @[Core.scala 57:22]
  wire [31:0] _op2_data_T_3 = _op2_data_T_2 ? imm_i_sext : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_4 = _op2_data_T_1 ? imm_s_sext : _op2_data_T_3; // @[Mux.scala 101:16]
  wire [31:0] op2_data = _op2_data_T ? rs2_data : _op2_data_T_4; // @[Mux.scala 101:16]
  wire  _alu_out_T = csignals_0 == 5'h1; // @[Core.scala 64:22]
  wire [31:0] _alu_out_T_2 = op1_data + op2_data; // @[Core.scala 64:48]
  wire [31:0] alu_out = _alu_out_T ? _alu_out_T_2 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _GEN_1 = csignals_3 ? alu_out : 32'h0; // @[Core.scala 21:18 69:28 71:21]
  wire  _T_1 = csignals_5 == 3'h1; // @[Core.scala 76:17]
  wire  _T_5 = ~reset; // @[Core.scala 87:11]
  assign regfile_rs1_data_MPORT_en = 1'h1;
  assign regfile_rs1_data_MPORT_addr = io_imem_inst[19:15];
  assign regfile_rs1_data_MPORT_data = regfile[regfile_rs1_data_MPORT_addr]; // @[Core.scala 15:22]
  assign regfile_rs2_data_MPORT_en = 1'h1;
  assign regfile_rs2_data_MPORT_addr = io_imem_inst[24:20];
  assign regfile_rs2_data_MPORT_data = regfile[regfile_rs2_data_MPORT_addr]; // @[Core.scala 15:22]
  assign regfile_MPORT_data = io_dmem_rdata;
  assign regfile_MPORT_addr = io_imem_inst[11:7];
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = _T_1 & csignals_4;
  assign io_dmem_addr = csignals_5 == 3'h1 & csignals_4 ? alu_out : _GEN_1; // @[Core.scala 76:48 77:22]
  assign io_dmem_wen = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  assign io_dmem_wdata = csignals_3 ? rs2_data : 32'h0; // @[Core.scala 19:19 69:28 72:23]
  assign io_imem_addr = pc_reg; // @[Core.scala 25:18]
  assign io_exit = io_imem_inst == 32'h5872e24d; // @[Core.scala 86:22]
  always @(posedge clock) begin
    if (regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[Core.scala 15:22]
    end
    if (reset) begin // @[Core.scala 18:25]
      pc_reg <= 32'h0; // @[Core.scala 18:25]
    end else begin
      pc_reg <= _pc_reg_T_1; // @[Core.scala 23:13]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"pc_reg : 0x%x\n",pc_reg); // @[Core.scala 87:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_5) begin
          $fwrite(32'h80000002,"inst : 0x%x\n",io_imem_inst); // @[Core.scala 90:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_5) begin
          $fwrite(32'h80000002,"--------\n"); // @[Core.scala 91:11]
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
module Memory(
  input         clock,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_inst,
  input  [31:0] io_dmem_addr,
  output [31:0] io_dmem_rdata,
  input         io_dmem_wen,
  input  [31:0] io_dmem_wdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] mem [0:16383]; // @[Memory.scala 25:18]
  wire  mem_io_imem_inst_MPORT_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_imem_inst_MPORT_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_imem_inst_MPORT_data; // @[Memory.scala 25:18]
  wire  mem_io_imem_inst_MPORT_1_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_imem_inst_MPORT_1_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_imem_inst_MPORT_1_data; // @[Memory.scala 25:18]
  wire  mem_io_imem_inst_MPORT_2_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_imem_inst_MPORT_2_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_imem_inst_MPORT_2_data; // @[Memory.scala 25:18]
  wire  mem_io_imem_inst_MPORT_3_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_imem_inst_MPORT_3_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_imem_inst_MPORT_3_data; // @[Memory.scala 25:18]
  wire  mem_io_dmem_rdata_MPORT_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_dmem_rdata_MPORT_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_dmem_rdata_MPORT_data; // @[Memory.scala 25:18]
  wire  mem_io_dmem_rdata_MPORT_1_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_dmem_rdata_MPORT_1_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_dmem_rdata_MPORT_1_data; // @[Memory.scala 25:18]
  wire  mem_io_dmem_rdata_MPORT_2_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_dmem_rdata_MPORT_2_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_dmem_rdata_MPORT_2_data; // @[Memory.scala 25:18]
  wire  mem_io_dmem_rdata_MPORT_3_en; // @[Memory.scala 25:18]
  wire [13:0] mem_io_dmem_rdata_MPORT_3_addr; // @[Memory.scala 25:18]
  wire [7:0] mem_io_dmem_rdata_MPORT_3_data; // @[Memory.scala 25:18]
  wire [7:0] mem_MPORT_data; // @[Memory.scala 25:18]
  wire [13:0] mem_MPORT_addr; // @[Memory.scala 25:18]
  wire  mem_MPORT_mask; // @[Memory.scala 25:18]
  wire  mem_MPORT_en; // @[Memory.scala 25:18]
  wire [7:0] mem_MPORT_1_data; // @[Memory.scala 25:18]
  wire [13:0] mem_MPORT_1_addr; // @[Memory.scala 25:18]
  wire  mem_MPORT_1_mask; // @[Memory.scala 25:18]
  wire  mem_MPORT_1_en; // @[Memory.scala 25:18]
  wire [7:0] mem_MPORT_2_data; // @[Memory.scala 25:18]
  wire [13:0] mem_MPORT_2_addr; // @[Memory.scala 25:18]
  wire  mem_MPORT_2_mask; // @[Memory.scala 25:18]
  wire  mem_MPORT_2_en; // @[Memory.scala 25:18]
  wire [7:0] mem_MPORT_3_data; // @[Memory.scala 25:18]
  wire [13:0] mem_MPORT_3_addr; // @[Memory.scala 25:18]
  wire  mem_MPORT_3_mask; // @[Memory.scala 25:18]
  wire  mem_MPORT_3_en; // @[Memory.scala 25:18]
  wire [31:0] _io_imem_inst_T_1 = io_imem_addr + 32'h3; // @[Memory.scala 30:22]
  wire [31:0] _io_imem_inst_T_4 = io_imem_addr + 32'h2; // @[Memory.scala 31:22]
  wire [31:0] _io_imem_inst_T_7 = io_imem_addr + 32'h1; // @[Memory.scala 32:22]
  wire [15:0] io_imem_inst_lo = {mem_io_imem_inst_MPORT_2_data,mem_io_imem_inst_MPORT_3_data}; // @[Cat.scala 31:58]
  wire [15:0] io_imem_inst_hi = {mem_io_imem_inst_MPORT_data,mem_io_imem_inst_MPORT_1_data}; // @[Cat.scala 31:58]
  wire [31:0] _io_dmem_rdata_T_1 = io_dmem_addr + 32'h3; // @[Memory.scala 36:22]
  wire [31:0] _io_dmem_rdata_T_4 = io_dmem_addr + 32'h2; // @[Memory.scala 37:22]
  wire [31:0] _io_dmem_rdata_T_7 = io_dmem_addr + 32'h1; // @[Memory.scala 38:22]
  wire [15:0] io_dmem_rdata_lo = {mem_io_dmem_rdata_MPORT_2_data,mem_io_dmem_rdata_MPORT_3_data}; // @[Cat.scala 31:58]
  wire [15:0] io_dmem_rdata_hi = {mem_io_dmem_rdata_MPORT_data,mem_io_dmem_rdata_MPORT_1_data}; // @[Cat.scala 31:58]
  assign mem_io_imem_inst_MPORT_en = 1'h1;
  assign mem_io_imem_inst_MPORT_addr = _io_imem_inst_T_1[13:0];
  assign mem_io_imem_inst_MPORT_data = mem[mem_io_imem_inst_MPORT_addr]; // @[Memory.scala 25:18]
  assign mem_io_imem_inst_MPORT_1_en = 1'h1;
  assign mem_io_imem_inst_MPORT_1_addr = _io_imem_inst_T_4[13:0];
  assign mem_io_imem_inst_MPORT_1_data = mem[mem_io_imem_inst_MPORT_1_addr]; // @[Memory.scala 25:18]
  assign mem_io_imem_inst_MPORT_2_en = 1'h1;
  assign mem_io_imem_inst_MPORT_2_addr = _io_imem_inst_T_7[13:0];
  assign mem_io_imem_inst_MPORT_2_data = mem[mem_io_imem_inst_MPORT_2_addr]; // @[Memory.scala 25:18]
  assign mem_io_imem_inst_MPORT_3_en = 1'h1;
  assign mem_io_imem_inst_MPORT_3_addr = io_imem_addr[13:0];
  assign mem_io_imem_inst_MPORT_3_data = mem[mem_io_imem_inst_MPORT_3_addr]; // @[Memory.scala 25:18]
  assign mem_io_dmem_rdata_MPORT_en = 1'h1;
  assign mem_io_dmem_rdata_MPORT_addr = _io_dmem_rdata_T_1[13:0];
  assign mem_io_dmem_rdata_MPORT_data = mem[mem_io_dmem_rdata_MPORT_addr]; // @[Memory.scala 25:18]
  assign mem_io_dmem_rdata_MPORT_1_en = 1'h1;
  assign mem_io_dmem_rdata_MPORT_1_addr = _io_dmem_rdata_T_4[13:0];
  assign mem_io_dmem_rdata_MPORT_1_data = mem[mem_io_dmem_rdata_MPORT_1_addr]; // @[Memory.scala 25:18]
  assign mem_io_dmem_rdata_MPORT_2_en = 1'h1;
  assign mem_io_dmem_rdata_MPORT_2_addr = _io_dmem_rdata_T_7[13:0];
  assign mem_io_dmem_rdata_MPORT_2_data = mem[mem_io_dmem_rdata_MPORT_2_addr]; // @[Memory.scala 25:18]
  assign mem_io_dmem_rdata_MPORT_3_en = 1'h1;
  assign mem_io_dmem_rdata_MPORT_3_addr = io_dmem_addr[13:0];
  assign mem_io_dmem_rdata_MPORT_3_data = mem[mem_io_dmem_rdata_MPORT_3_addr]; // @[Memory.scala 25:18]
  assign mem_MPORT_data = io_dmem_wdata[7:0];
  assign mem_MPORT_addr = io_dmem_addr[13:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_dmem_wen;
  assign mem_MPORT_1_data = io_dmem_wdata[15:8];
  assign mem_MPORT_1_addr = _io_dmem_rdata_T_7[13:0];
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_dmem_wen;
  assign mem_MPORT_2_data = io_dmem_wdata[23:16];
  assign mem_MPORT_2_addr = _io_dmem_rdata_T_4[13:0];
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = io_dmem_wen;
  assign mem_MPORT_3_data = io_dmem_wdata[31:24];
  assign mem_MPORT_3_addr = _io_dmem_rdata_T_1[13:0];
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = io_dmem_wen;
  assign io_imem_inst = {io_imem_inst_hi,io_imem_inst_lo}; // @[Cat.scala 31:58]
  assign io_dmem_rdata = {io_dmem_rdata_hi,io_dmem_rdata_lo}; // @[Cat.scala 31:58]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Memory.scala 25:18]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[Memory.scala 25:18]
    end
    if (mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[Memory.scala 25:18]
    end
    if (mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[Memory.scala 25:18]
    end
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
  for (initvar = 0; initvar < 16384; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Top(
  input   clock,
  input   reset,
  output  io_exit
);
  wire  core_clock; // @[Top.scala 12:20]
  wire  core_reset; // @[Top.scala 12:20]
  wire [31:0] core_io_dmem_addr; // @[Top.scala 12:20]
  wire [31:0] core_io_dmem_rdata; // @[Top.scala 12:20]
  wire  core_io_dmem_wen; // @[Top.scala 12:20]
  wire [31:0] core_io_dmem_wdata; // @[Top.scala 12:20]
  wire [31:0] core_io_imem_addr; // @[Top.scala 12:20]
  wire [31:0] core_io_imem_inst; // @[Top.scala 12:20]
  wire  core_io_exit; // @[Top.scala 12:20]
  wire  memory_clock; // @[Top.scala 13:22]
  wire [31:0] memory_io_imem_addr; // @[Top.scala 13:22]
  wire [31:0] memory_io_imem_inst; // @[Top.scala 13:22]
  wire [31:0] memory_io_dmem_addr; // @[Top.scala 13:22]
  wire [31:0] memory_io_dmem_rdata; // @[Top.scala 13:22]
  wire  memory_io_dmem_wen; // @[Top.scala 13:22]
  wire [31:0] memory_io_dmem_wdata; // @[Top.scala 13:22]
  Core core ( // @[Top.scala 12:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_dmem_addr(core_io_dmem_addr),
    .io_dmem_rdata(core_io_dmem_rdata),
    .io_dmem_wen(core_io_dmem_wen),
    .io_dmem_wdata(core_io_dmem_wdata),
    .io_imem_addr(core_io_imem_addr),
    .io_imem_inst(core_io_imem_inst),
    .io_exit(core_io_exit)
  );
  Memory memory ( // @[Top.scala 13:22]
    .clock(memory_clock),
    .io_imem_addr(memory_io_imem_addr),
    .io_imem_inst(memory_io_imem_inst),
    .io_dmem_addr(memory_io_dmem_addr),
    .io_dmem_rdata(memory_io_dmem_rdata),
    .io_dmem_wen(memory_io_dmem_wen),
    .io_dmem_wdata(memory_io_dmem_wdata)
  );
  assign io_exit = core_io_exit; // @[Top.scala 16:11]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_dmem_rdata = memory_io_dmem_rdata; // @[Top.scala 15:16]
  assign core_io_imem_inst = memory_io_imem_inst; // @[Top.scala 14:16]
  assign memory_clock = clock;
  assign memory_io_imem_addr = core_io_imem_addr; // @[Top.scala 14:16]
  assign memory_io_dmem_addr = core_io_dmem_addr; // @[Top.scala 15:16]
  assign memory_io_dmem_wen = core_io_dmem_wen; // @[Top.scala 15:16]
  assign memory_io_dmem_wdata = core_io_dmem_wdata; // @[Top.scala 15:16]
endmodule

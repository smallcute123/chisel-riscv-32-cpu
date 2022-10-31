module BindsTo_0_Memory(
  input         clock,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_inst
);

initial begin
  $readmemh("src/hex/fetch.hex", Memory.mem);
end
                      endmodule

bind Memory BindsTo_0_Memory BindsTo_0_Memory_Inst(.*);
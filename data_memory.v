// Simple single‐port data memory with separate read/write ports.
//////////////////////////////////////////////////////////////////////////////////
// 
// Project Name: RISC V Processor
// Module Name: data_memory
// Description: Design of Data Memory / LS unit.
// 
// Additional Comments: Load-Store Unit where write is synchronous to clk n read is asynchronous
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module data_memory (
    input  wire        clk,        // clock
    input  wire        rst,        // active‐high synchronous reset
    input  wire [4:0]  wr_addr,    // write address (5‐bit → 32 words)
    input  wire [31:0] wr_data,    // data to write
    input  wire        wr_en,      // write enable (assert to store wr_data)
    input  wire [4:0]  rd_addr,    // read address
    output wire [31:0] rd_data     // read data
);

  // 32‐word × 32‐bit memory
  reg [31:0] mem [0:31];
  integer    i;

  // Synchronous write + reset clearing
  always @(posedge clk) begin
    if (rst) begin
      // Clear entire memory on reset
      for (i = 0; i < 32; i = i + 1)
        mem[i] <= 32'b0;
    end
    else if (wr_en) begin
      // Write new data
      mem[wr_addr] <= wr_data;
    end
  end

  // Asynchronous read
  assign rd_data = mem[rd_addr];

endmodule

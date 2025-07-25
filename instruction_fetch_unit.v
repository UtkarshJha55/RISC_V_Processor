//////////////////////////////////////////////////////////////////////////////////
// 
// Project Name: RISC V Processor
// Module Name: instruction_fetch_unit
// Description: Design of instruction fetch unit.
// 
// Additional Comments: It fetches the branch instructions and updates the program counter
// 
//////////////////////////////////////////////////////////////////////////////////

module instruction_fetch_unit(
    input clk,                           // Clock source
    input reset,                         // Reset signal
    input [31:0] imm_address,            // Immediate address for branch instructions
    input [31:0] imm_address_jump,       // Immediate address for jump instructions
    input beq,                           // Control signal for enabling beq operation
    input bneq,                          // Control signal for enabling bneq operation
    input bge,                           // Control signal for enabling bge operation
    input blt,                           // Control signal for enabling blt operation
    input jump,                          // Control signal for enabling jump operation
    output reg [31:0] pc,                // Programme counter
    output reg [31:0] current_pc         // Register for storing return address of programme counter
);

// Updating Program Counter based on instructions
always@(posedge clk)
    begin
        if(reset == 1)
            begin
                pc <= 0;
            end
        else if(beq == 0 && bneq == 0 && bge == 0 && blt == 0 && jump == 0)
            pc <= pc + 4;
        else if(beq == 1 || bneq == 1 || bge == 1 || blt == 1)
            pc <= pc + imm_address;
        else if(jump)
            pc <= pc + imm_address_jump;
    end

// Storing return address of PC
always@(posedge clk)
begin
    if(reset)
    begin
        current_pc = 0;
    end
    else if(reset == 0 && jump == 0)
        current_pc <= pc + 4;
    else
        current_pc <= current_pc;
end
endmodule

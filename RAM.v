module ram
#(parameter SIZE = 512,
  parameter WIDTH = 16,
  parameter ADDR = 9)
(
  input CLK,CLK_en,
  input [WIDTH-1:0] shiftin,     // data in
  input [ADDR-1:0] wr_addr,      // write address
  output reg [WIDTH-1:0] shiftout, //shift output
  input [ADDR-1:0] rd_addr,      // read address
  input rd_en,              // read enable
  input reset                     // reset (sync/async)
);

//simple dual port
  reg [WIDTH-1:0] mem [SIZE-1:0];


// Shift Register
  //write
  always @(posedge CLK) begin
    if(CLK_en && !reset) begin
      mem[wr_addr] <= shiftin;
    end
  end

  //read
  always @(posedge CLK or posedge reset) begin
    if(reset) begin
      shiftout <= {WIDTH{1'b0}}; 
    end 
    else if(CLK_en && rd_en) begin
      shiftout <= mem[rd_addr]; 
    end
  end

endmodule

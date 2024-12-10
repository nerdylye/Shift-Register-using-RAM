module shiftregister
#(parameter SIZE = 512,
  parameter WIDTH = 16)
(
  input CLK,CLK_en,reset,
  input [WIDTH-1:0] shiftin,     // data in
  output reg [WIDTH-1:0] shiftout //shift output
);
localparam ADDR = $clog2(SIZE);
reg [ADDR-1:0] wr_addr;      // write address
reg [ADDR-1:0] rd_addr;      // read address
reg rd_en;              // read enable

reg full;
assign rd_en = full;
reg [ADDR-1:0] counter;

// Write control
always @(posedge CLK) begin
  if(reset) begin
    wr_addr <= 1'b0;
    counter <= 1'b0;
    full <= 1'b0;
  end
  else if(CLK_en) begin
    if(counter < SIZE-1) begin
      counter <= counter + 1'b1;
    end
    else begin
      full <= 1'b1;
    end
    wr_addr <= wr_addr + 1'b1;
  end
end

// Read control
always @(posedge CLK) begin
  if(reset)begin
    rd_addr <= 1'b0;
  end
  else if(CLK_en && rd_en) begin
    rd_addr <= rd_addr + 1'b1;
  end
end

ram #(
  .SIZE(SIZE),
  .WIDTH(WIDTH),
  .ADDR(ADDR)
)
ram1 (
  .CLK(CLK),
  .CLK_en(CLK_en),
  .reset(reset),
  .shiftin(shiftin),
  .wr_addr(wr_addr),
  .rd_addr(rd_addr),
  .rd_en(rd_en),
  .shiftout(shiftout)
);

endmodule

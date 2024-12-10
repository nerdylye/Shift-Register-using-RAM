module shiftreg_tb;
  parameter SIZE = 8;
  parameter WIDTH = 8;

  reg CLK = 0, CLK_en, reset;
  reg [WIDTH-1:0] shiftin;
  wire [WIDTH-1:0] shiftout;

  shiftregister
  #(.SIZE(SIZE),
    .WIDTH(WIDTH)
  )
  dut(
    .CLK(CLK),
    .CLK_en(CLK_en),
    .reset(reset),
    .shiftin(shiftin),
    .shiftout(shiftout)
  );

  always #5 CLK = ~CLK;

  initial begin
    reset = 1'b1;
    #15;
    reset = 1'b0;
    #1000;
    $finish;
  end

  always @(negedge CLK) begin
    shiftin <= $urandom;
  end


  initial begin
    #20;
    for(int i =0; i<=SIZE*5; i++) begin
      @(posedge CLK);
      CLK_en <= 1'b1;
    end
    CLK_en <= 1'b0;
  end

  initial begin
    $dumpfile("shiftreg.vcd"); $dumpvars(0,shiftreg_tb);
    #1000;
    $finish;
  end


endmodule 

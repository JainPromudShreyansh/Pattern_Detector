`include "Pattern_Detector_Design.v"

module tb;
parameter S_RST=3'b000;
parameter S_B=3'b001;
parameter S_BB=3'b010;
parameter S_BBC=3'b011;
parameter S_BBCB=3'b100;
parameter S_BBCBC=3'b101;
parameter B=1'b0;
parameter C=1'b1;

reg clk,rst,valid,in;
wire out;

integer count;


pattern_det dut(clk,rst,valid,in,out);

always #20 clk=~clk;

initial begin
count=0;
clk=0;
rst=1;
#50;
rst=0;
repeat(500) begin
@(posedge clk);
in=$random;
valid=1;
end
valid=0;
#400;
$display("Number of times Pattern Detetected=%0d",count);
$finish;
end

always @( posedge out) count=count+1;
endmodule

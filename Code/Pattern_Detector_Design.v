//////////////////////////////////////////////////////////////////////////////////
//Designer: Shreyansh Promud Jain
// Design Name: Pattern Detetor
// Module Name:
// Project Name: Pattern Detetor
// Description: Detecting a pattern(Bike->Bike->Car->Bike->Car or BBCBC). 
//////////////////////////////////////////////////////////////////////////////////
module pattern_det(clk,rst,valid,in,out);
parameter S_RST=3'b000;
parameter S_B=3'b001;
parameter S_BB=3'b010;
parameter S_BBC=3'b011;
parameter S_BBCB=3'b100;
parameter S_BBCBC=3'b101;
parameter B=1'b0;
parameter C=1'b1;

input clk,rst,valid,in;
output reg out;

//3 ff needed for each stage (binary coding)
reg[2:0] state, next_state;

always @(posedge clk) begin
	if(rst==1) begin
		out=0;
		state=0;
		next_state=0;
		end
	else
		if(valid==1)begin
			out=0;
			case(state)
				S_RST:begin
					if(in==B) next_state=S_B;
					else next_state=S_RST;
				end
				S_B:begin
					if(in==B) next_state=S_BB;
					else next_state=S_RST;
				end
				S_BB:begin
					if(in==B) next_state=S_BB;
					else next_state=S_BBC;
				end
				S_BBC:begin
					if(in==B) next_state=S_BBCB;
					else next_state=S_RST;
				end
				S_BBCB:begin
					if(in==B) next_state=S_BB;
					else next_state=S_BBCBC;
				end
				S_BBCBC:begin
					out=1;
					if(in==B) next_state=S_B;
					else next_state=S_RST;
				end

				default: begin
				$display("Invalid Input");
				end
			endcase	
		end
	end	
 always @(next_state) state=next_state;
endmodule

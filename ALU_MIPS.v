module ALU_MIPS(in_1,in_2, zero, result, ctrl);
input [31:0] in_1,  in_2;
input [3:0] ctrl;
output reg zero;
output reg [31:0] result;

always @ (*)
begin
	case(ctrl)
    	4'b0010: begin
    	result = in_1 + in_2;
    	if (result == 0) zero=1;
    	else zero=0;
    	end
    	4'b0110: begin
     	result = in_1 - in_2;
     	if (result == 0) zero=1;
     	else zero=0;
     	end
    	4'b0000: begin
    	result = in_1 ^ in_2;
    	if ( result == 0) zero=1;
    	else zero=0;
    	end
    	4'b0001: begin
    	result = in_1 | in_2;
    	if ( result == 0) zero=1;
    	else zero=0;
    	end
    	default: begin
    	result = 32'bx;
    	zero = 1'bx;
    	end
	endcase
end
endmodule

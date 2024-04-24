module Hazard_detection(rs_IF_ID, rt_IF_ID, rt_ID_EX, MemRead_ID_EX, stall, PC_write);

input [4:0] rs_IF_ID, rt_IF_ID, rt_ID_EX; 
input MemRead_ID_EX;

output stall;
output PC_write;

assign stall = ((rs_IF_ID == rt_ID_EX || rt_IF_ID == rt_ID_EX) && MemRead_ID_EX) ? 1 : 0;
assign PC_write = stall ? 0 : 1;

endmodule
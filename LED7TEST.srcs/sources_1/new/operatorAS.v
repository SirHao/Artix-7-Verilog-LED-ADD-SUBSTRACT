`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 09:55:59
// Design Name: 
// Module Name: operatorAS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module operatorAS(
input a1,input b1,
input a2,input b2,
input a3,input b3,
input a4,input b4,
output reg [3:0] i,
output reg [3:0] j,
input cin,
input whetherAdd,
output reg underZ,
output reg [4:0] k,
output reg over
    );
reg [3:0] temp;
always @(*)
begin
i={a1,a2,a3,a4};
j={b1,b2,b3,b4};
case(whetherAdd)
    0:
    begin
        k=i+j+cin;
        over=k[4];
        underZ=0;
    end
    1:
    begin
        underZ=0;
        temp= (~i) +1;
        k=j+temp+cin;
        over=k[4]; 
        if(j<i)
        begin
            underZ=1;
            temp=(~j)+1;
            k=i+temp+cin;
        over=k[4]; 
        end 
    end
endcase

end
endmodule

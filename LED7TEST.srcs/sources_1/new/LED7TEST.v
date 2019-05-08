`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 18:57:57
// Design Name: 
// Module Name: LED7TEST
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


module LED7TEST(
input a1,
input b1,
input a2,
input b2,
input a3,
input b3,
input a4,
input b4,
input clk,
input cin,
input whetherAdd,
output wire over,
output reg [7:0] led_id,
output reg [7:0] out_led
    );
wire [3:0] i,j;
wire [4:0] k;
wire underZ;
/*
assign i={a1,a2,a3,a4};
assign j={b1,b2,b3,b4};
assign k=i+j+cin;
assign over=k[4];*/
operatorAS myo(.a1(a1),.b1(b1),
                .a2(a2),.b2(b2),
                .a3(a3),.b3(b3),
                .a4(a4),.b4(b4),.i(i),.j(j),.cin(cin),.whetherAdd(whetherAdd),.underZ(underZ),.k(k),.over(over));//
reg [1:0] pos;
reg [10:0] segclk;
reg [4:0] outputtemp;

always @(*)
case(pos)
0:led_id=8'b1111_1110;
1:led_id=8'b1111_0111;
2:led_id=8'b0111_1111;
3:led_id=8'b1111_1101;
endcase

always @(posedge clk)
begin
    segclk=segclk+1;
    if(segclk[10]==1) 
    begin
        segclk=0;
        case(pos)
            2'b00:
            begin
                pos=2'b01;
                outputtemp=i;
                
             end 
            2'b01:
            begin  
                 pos=2'b10;             
                outputtemp=j;
                
            end
            2'b10:
            begin
            if(underZ==1)
            begin
                outputtemp[4]=1;
                outputtemp[3]=1;
                outputtemp[2]=1;
                outputtemp[1]=1;
                outputtemp[0]=1;
            end
            else
            begin
                outputtemp[4]=1;
                outputtemp[3]=1;
                outputtemp[2]=1;
                outputtemp[1]=1;
                outputtemp[0]=0;
            end
                pos=2'b11;
                
                
                
            end
            2'b11:
            begin     
                pos=2'b00;           
                outputtemp=k[3:0];
                
            end
        endcase
    end
end

always @(*)
case(outputtemp)
    5'b00000:out_led=8'b0000_0011;
    5'b00001:out_led=8'b1001_1111;
    5'b00010:out_led=8'b0010_0101;
    5'b00011:out_led=8'b0000_1101;
    
    5'b00100:out_led=8'b1001_1001;
    5'b00101:out_led=8'b0100_1001;
    5'b00110:out_led=8'b0100_0001;
    5'b00111:out_led=8'b0001_1111;
    
    5'b01000:out_led=8'b0000_0001;
    5'b01001:out_led=8'b0001_1001;
    5'b01010:out_led=8'b0001_0001;
    5'b01011:out_led=8'b1100_0001;
    
    5'b01100:out_led=8'b1110_0101;
    5'b01101:out_led=8'b1000_0101;
    5'b01110:out_led=8'b0110_0001;
    5'b01111:out_led=8'b0111_0001;

    5'b11111:out_led=8'b1111_1101;
    5'b11110:out_led=8'b1111_1110;
    default:
     out_led=8'b1111_1111;
endcase
endmodule

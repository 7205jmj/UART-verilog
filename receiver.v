`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:56:21
// Design Name: 
// Module Name: receiver
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



module receiver(
input clk,rst,
input rx,stick,
output reg [7:0] rxdout,
output reg rxdonetick
    );
parameter DBIT =8;
parameter SBTICK =16;
parameter IDLE =0,START =1,DATA=2,STOP=3;
reg [1:0] cs,ns;
reg[3:0] sreg,snext;
reg[3:0] nreg,nnext;
reg[7:0]breg,bnext;
reg [7:0]rxdoutnext;
reg  rxdoneticknext;
always@(posedge clk or negedge rst)begin
if(!rst)begin
cs <= IDLE;
sreg <=0;
nreg <=0;
breg<=0;
rxdout <=0;
rxdonetick <=0;
end
else begin
cs<=ns;
sreg <= snext;
nreg <=nnext;
breg <= bnext;
rxdout <= rxdoutnext;
rxdonetick<=rxdoneticknext;
end
end
always @* begin
ns =cs;
snext =sreg;
nnext =nreg;
bnext = breg;
rxdoutnext = rxdout;
rxdoneticknext=0;
case(cs)
IDLE :begin
if(!rx)begin
ns =START;
snext =0;
end
end
START :begin
 if(stick) begin
    if(sreg == 7)begin
    snext=0;
    nnext =0;
    ns=DATA;
    end else
    snext =sreg +1;
    end
    end
    
    DATA : begin 
    if(stick)begin
    if(sreg ==15)begin
    snext =0;
    bnext ={rx,breg[7:1]};
    if(nreg ==DBIT-1)
    ns=STOP;
    else
    nnext =nreg +1;
    end else
    snext = sreg+2;
    end    
    end
    
    
    STOP :begin
if(stick)begin
if(sreg == SBTICK -1) begin
    ns =IDLE;
   rxdoutnext =breg;
   rxdoneticknext =1;
    end else
    snext =sreg +1;
    end
    end
    endcase
    end
endmodule


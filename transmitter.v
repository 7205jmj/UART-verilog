`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:57:01
// Design Name: 
// Module Name: transmitter
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



module transmitter(
input clk,rst,
input txstart,stick,
input [7:0] txdin,
output reg tx,
output reg txdonetick
    );
parameter DBIT =8;
parameter SBTICK =16;
parameter IDLE =0,START =1,DATA=2,STOP=3;
reg [1:0] cs,ns;
reg[3:0] sreg,snext;
reg[3:0] nreg,nnext;
reg[7:0]breg,bnext;
reg txnext,txdoneticknext;

//state memory
always@(posedge clk or negedge rst)begin
if(!rst)begin
cs <= IDLE;
sreg <=0;
nreg <=0;
breg<=0;
tx<=1;
txdonetick <=0;
end
else begin
cs<=ns;
sreg <= snext;
nreg <=nnext;
breg <= bnext;
tx <= txnext;
txdonetick<=txdoneticknext;
end
end

//next state logic 
always @* begin
ns =cs;
snext =sreg;
nnext =nreg;
bnext = breg;
txnext = tx;
txdoneticknext=0;
case(cs)
    IDLE :begin
    txnext =1;
    if(txstart)begin
    bnext =txdin;
    snext =0;
    ns=START;
    end
    end
    START:begin
    txnext =0;
    if(stick) begin
    if(sreg == 15)begin
    snext=0;
    nnext =0;
    ns=DATA;
    end else
    snext =sreg +1;
    end
    end
    DATA : begin 
    txnext=breg[0];
    if(stick)begin
    if(sreg ==15)begin
    snext =0;
    bnext =breg >>1;
    if(nreg ==DBIT-1)
    ns=STOP;
    else
    nnext =nreg +1;
    end else
    snext = sreg+2;
    end    
    end
STOP :begin
txnext =1;
if(stick)begin
if(sreg == SBTICK -1) begin
    ns =IDLE;
    txdoneticknext =1;
    end else
    snext =sreg +1;
    end
    end
    endcase
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:57:41
// Design Name: 
// Module Name: UARTTOP
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



module UARTTOP(
input rx,clk,wruart,rduart,rstn,
input [7:0] wdata,
output tx,txfull,rxempty,
output [7:0] rdata
    );
    wire stick;
    wire [7:0] txfifodout;
    wire txdonetick,txfifoempty,txstart;
    wire [7:0] rxdatawire;
    wire rxdonetick,rxfifofull;
    assign txstart =~txfifoempty;
     baud_generator bg(.clk(clk),.rstn(rstn),.baud_clk(stick));
    
    transmitter  txunit(.clk(clk),.rst(rst),.txstart(txstart),.stick(stick),.txdin(txfifodout),
.tx(tx),.txdonetick(txdonetick)
    );
    fifo txfifo(.dinA(wdata),.wenb(wruart),.renb(txdonetick),.clka(clk),.clkb(clk),.rst(rst),
    .doutb(txfifodout),.full(txfull),.empty(txfifoempty));
    
    receiver  rxunit(.clk(clk),.rst(rst),.rx(rx),.stick(stick),.rxdout(rxdatawire),.rxdonetick(rxdonetick)
    );
     fifo rxfifo(.dinA(rxdatawire),.wenb(rxdonetick),.renb(rduart),.clka(clk),.clkb(clk),.rst(rst),
    .doutb(rdata),.full(rxfifofull),.empty(rxempty));
    
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:59:13
// Design Name: 
// Module Name: UARTTB
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


module UARTTB();
reg clk, wruart,rduart,rstn;
reg [7:0] wdata;
wire tx,txfull,rxempty;
wire [7:0] rdata;
wire [7:0] rx;
assign rx = tx;
UARTTOP uartprotocol(.clk(clk),.wruart(wruart),.rduart(rduart),.rstn(rstn),.wdata(wdata),
.tx(tx),.txfull(txfull),.rxempty(rxempty),.rdata(rdata),.rx(rx));
initial begin
clk =0;
forever #1 clk = ~clk;
end
initial begin
wruart =0;
rduart =0;
wdata=8'h00;
rstn=0;
repeat(1) @(negedge clk);
rstn =1;
@(negedge clk);
repeat(100)begin
wruart =1;
wdata =$random;
@(negedge clk);
wruart =0;
repeat(1000)@(negedge clk);
if(!rxempty)begin
rduart =1;
@(negedge clk);
rduart =0;
@(negedge clk);
end
end
$finish;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:54:46
// Design Name: 
// Module Name: baud_generator
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



module baud_generator(clk,rstn,baud_clk);
parameter boud_rate=9600;
parameter clk_freq = 1000000;
parameter sampling =16;
parameter n=9;
parameter divisor =(clk_freq/(boud_rate *sampling));
input clk,rstn;
output  reg baud_clk;
reg[n-1:0] count;
always @(posedge clk or negedge rstn)
    begin
    if(!rstn)begin
    baud_clk <=0;
    count <= 0;
    end
    else if(count == divisor -1)begin
        count <=0;
        baud_clk<= ~baud_clk;
    end
    else 
    begin
        count <= count + 1;
       
    end
    end

endmodule

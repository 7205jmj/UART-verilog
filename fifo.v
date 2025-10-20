`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 22:55:34
// Design Name: 
// Module Name: fifo
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

module fifo #(
parameter fifowidth =8,
parameter addrwidth=9,
parameter fifodepth = 512
)(
    input [fifowidth-1:0] dinA,
    input wenb,renb,clka,clkb,rst,
    output reg[fifowidth-1:0] doutb,
    output full,empty
    );
    reg[addrwidth-1:0] wrpt,rdpt;
    reg[fifowidth-1:0]mem [addrwidth-1:0];
    
    
    // write logic
    always@(posedge clka or negedge rst)begin
    if(!rst)
    wrpt <=0;
    else if(wenb && !full)begin
    mem[wrpt] <= dinA;
    wrpt <= wrpt +1;
    end
    end
    
    //read logic 
    always@(posedge clkb or negedge rst)begin
    if(!rst)begin
    rdpt <=0;
    doutb <=0;
    end
    else if( renb && !empty)begin
    doutb<= mem[rdpt];
    rdpt<= rdpt +1;
    end
    end
    assign empty = (wrpt == rdpt);
    assign  full =((wrpt +1'b1)== rdpt);
endmodule




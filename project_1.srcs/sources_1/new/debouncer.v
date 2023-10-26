`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 14:22:49
// Design Name: 
// Module Name: debouncer
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

module debouncer(
    input wire clk,
    input wire in,
    output wire out
    );

    wire connect1, connect2;
    wire Q1, Q2_bar, Q_2;
    dff Udff0(clk, in,Q1 );
    dff Udff1(clk, Q1,Q2 );

    assign Q2_bar = ~Q2;
    assign out = Q1 & Q2_bar;
endmodule


module dff(
    input wire clk, 
    input wire in, 
    output reg out);

    always @ (posedge clk) begin
        out <= in;
    end
endmodule

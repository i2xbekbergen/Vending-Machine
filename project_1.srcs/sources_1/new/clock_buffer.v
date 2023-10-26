`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/04 11:38:38
// Design Name: 
// Module Name: clock_buffer
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


module clock_buffer(
    input wire clk_5MHz,//from Uclk_wizard0
    input wire resetn,
    output reg clk_50Hz 
    );

    reg  [15:0] cnt_50000;//to generate 50Hz

    always @ (posedge clk_5MHz, negedge resetn) begin
        /* assign cnt_50000 */
        if (!resetn) begin 
            cnt_50000 <= 16'd0;
        end else begin 
            if (cnt_50000 == 16'd49999) begin
                cnt_50000 <= 16'd0;
            end
            else begin cnt_50000 <= cnt_50000 + 16'd1; end
        end
    end
    

    always @ (posedge clk_5MHz, negedge resetn) begin
        if (!resetn) begin
            clk_50Hz <= 1'b0;
        end
        else begin
            if (cnt_50000 == 16'd49999) begin
                clk_50Hz <= ~clk_50Hz;
            end
        end
    end
    
endmodule

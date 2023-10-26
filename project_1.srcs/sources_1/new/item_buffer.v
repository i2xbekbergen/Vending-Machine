`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 13:53:25
// Design Name: 
// Module Name: item_buffer
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


module item_buffer(
    input wire clk,
    input wire resetn,
    input wire [1:0] state,
    input wire btn1, btn2, btn3,
    input wire [5:0] balance,

    output reg [2:0] stock1, stock2, stock3
    );

    localparam IDLE = 2'b00;
    localparam ITEM_FILLING = 2'b01;
    localparam INSERT_COIN = 2'b10;
    localparam SELLING = 2'b11;

    //Tips
    //Never assign different reg in the same always loop, this is not Python coding
    //Define every case for each reg.

    always @(posedge clk or negedge resetn) begin
        /*assign stock1 */
        if (resetn == 0) begin stock1 <= 3'b000; end
        else begin
            case(state)
                ITEM_FILLING: begin
                    if (btn1 == 1) begin
                        if (stock1 < 3'b101) begin stock1 <= stock1 + 3'b001; end
                        else begin stock1 <= stock1; end
                    end
                end
                
                SELLING: begin
                    if (btn1 == 1) begin
                        if ((balance > 6'b000101) && (stock1 != 3'b000)) begin stock1 <= stock1 - 3'b001; end
                        else begin stock1 <= stock1; end
                    end
                end
                
                default: begin
                    stock1 <= stock1;
                end
            endcase    
        end
         
    end

    always @(posedge clk or negedge resetn) begin
        /*assign stock2 */
        if (resetn == 0) begin stock2 <= 3'b000; end
        else begin
            case(state)
                ITEM_FILLING: begin
                    if (btn2 == 1) begin
                        if (stock2 < 3'b101) begin stock2 <= stock2 + 3'b001; end
                        else begin stock2 <= stock2; end
                    end
                end
                
                SELLING: begin
                    if (btn2 == 1) begin
                        if ((balance > 6'b000101) && (stock2 != 3'b000)) begin stock2 <= stock2 - 3'b001; end
                        else begin stock2 <= stock2; end
                    end
                end
                
                default: begin
                    stock2 <= stock2;
                end
                
            endcase    
        end
    end

    always @(posedge clk or negedge resetn) begin
        /*assign stock3 */
        if (resetn == 0) begin stock3 <= 3'b000; end        
        else begin
            case(state)
                ITEM_FILLING: begin
                    if (btn3 == 1) begin
                        if (stock3 < 3'b101) begin stock3 <= stock3 + 3'b001; end
                        else begin stock3 <= stock3; end
                    end
                end
                
                SELLING: begin
                    if (btn3 == 1) begin
                        if ((balance > 6'b000101) && (stock3 != 3'b000)) begin stock3 <= stock3 - 3'b001; end
                        else begin stock3 <= stock3; end
                    end
                end
                
                default: begin
                    stock3 <= stock3;
                end
                
            endcase    
            end
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 13:41:21
// Design Name: 
// Module Name: coin_buffer
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


module coin_buffer(
    input wire clk,
    input wire resetn,

    input wire [1:0] state,
    input wire btn1, btn2, btn3,
    input wire [2:0] stock1, stock2, stock3,
    output reg [5:0] balance
    );

    localparam IDLE = 2'b00;
    localparam ITEM_FILLING = 2'b01;
    localparam INSERT_COIN = 2'b10;
    localparam SELLING = 2'b11;

    reg [2:0] btn;
    always @ (posedge clk or negedge resetn) begin
        /*assign balance */
        btn = {btn1, btn2, btn3};
        if (resetn == 0) begin 
            balance <= 0;
        end else begin
            case(state)
                INSERT_COIN: begin
                    case(btn)
                        3'b100:
                            if (balance < 6'b110010) begin balance <= balance + 6'b000001; end // +1
                            else begin balance <= balance; end
                        3'b010: 
                            if (balance < 6'b101110) begin balance <= balance + 6'b000101; end // +5
                            else begin balance <= balance; end
                        3'b001: 
                            if (balance < 6'b101001) begin balance <= balance + 6'b001010; end // +10
                            else begin balance <= balance; end
                     endcase
                end
                SELLING: begin
                    case(btn)
                        3'b100:
                            if ((balance > 6'b000011) && (stock1 != 3'b000)) begin balance <= balance - 6'b000011; end // -3
                            else begin balance <= balance; end
                        3'b010:
                            if ((balance > 6'b000101) && (stock2 != 3'b000)) begin balance <= balance - 6'b000101; end // -5
                            else begin balance <= balance; end                        
                        3'b001:
                            if ((balance > 6'b000111) && (stock3 != 3'b000)) begin balance <= balance - 6'b000111; end // -7
                            else begin balance <= balance; end
                    endcase
                end
                default: begin
                    balance <= balance;
                end      
            endcase 
        end
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 13:26:21
// Design Name: 
// Module Name: fsm_ctrlr
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


module fsm_ctrlr(
    input clk,
    input resetn,
    input sw3, sw2, sw1,
    output wire [1:0] state_out
    );
     //You can change the state. The code will not reviewed!
    localparam IDLE = 2'b00;
    localparam ITEM_FILLING = 2'b01; 
    localparam INSERT_COIN = 2'b10; 
    localparam SELLING = 2'b11; 

    reg [1:0] state, n_state;
    reg [1:0] sw;
    
    assign state_out = state;

    always @(*) begin
        sw = {sw1, sw2};
        /* assign n_state Here */
        case (state)
            IDLE : begin 
                case (sw) 
                    2'b00: begin
                        n_state = SELLING;
                    end
                    2'b01: begin
                        n_state = ITEM_FILLING;
                    end
                    2'b10: begin
                        n_state = INSERT_COIN; 
                    end
                    2'b11: begin
                        n_state = INSERT_COIN; 
                    end
                endcase
            end 
            
            ITEM_FILLING : begin 
                case (sw) 
                    2'b00: begin
                        n_state = SELLING;
                    end
                    2'b01: begin
                        n_state = ITEM_FILLING;   
                    end   
                    2'b10: begin
                        n_state = INSERT_COIN;
                    end
                    2'b11: begin
                        n_state = INSERT_COIN;   
                    end
                endcase
            end 
            
            INSERT_COIN : begin 
                case (sw) 
                    2'b00: begin
                        n_state = SELLING;
                    end
                    2'b01: begin
                        n_state = ITEM_FILLING;   
                    end   
                    2'b10: begin
                        n_state = INSERT_COIN;
                    end
                    2'b11: begin
                        n_state = INSERT_COIN;   
                    end
                endcase
            end      
            
            SELLING : begin 
                case (sw) 
                    2'b00: begin
                        n_state = SELLING;
                    end
                    2'b01: begin
                        n_state = ITEM_FILLING;   
                    end   
                    2'b10: begin
                        n_state = INSERT_COIN;
                    end
                    2'b11: begin
                        n_state = INSERT_COIN;
                    end
                endcase
            end               
            
            default : begin 
                n_state = IDLE;         
            end 
        endcase
       
    end

    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            state <= IDLE;
        end
        else begin
            state <= n_state;
        end
    end


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 13:15:21
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(
    input wire clk,
    input wire reset,
    input wire btn1, btn2, btn3,
    input wire sw3, sw2, sw1,
    output wire LED5, 
    output reg LED4, LED3, LED2,
    output wire aa, ab, ac, ad, ae, af, ag, cat
    );

    localparam IDLE = 2'b00;
    localparam ITEM_FILLING = 2'b01;
    localparam INSERT_COIN = 2'b10;
    localparam SELLING = 2'b11;


    wire clk_5MHz, clk_50Hz;
    wire resetn;
    wire btn1_f, btn2_f, btn3_f; 
    wire [1:0] state;
    wire [5:0] balance;
    wire [2:0] stock1, stock2, stock3;

    reg [6:0] value; // value represented on the SSD
    reg [1:0] val_sel; // this is used to decide which stock will be represented on SSD in ITEM_FILLING mode

    reg [3:0] btn_led;
    reg [2:0] btn;
        
    assign LED5 = sw3;/* fill */
    assign resetn = ~reset;

    always @(*) begin
    
        btn_led = {btn1, btn2, btn3};
        case(state)
        /* assign LED2 for each MODE */
            ITEM_FILLING: begin
                case (val_sel)
                    3'b00: begin LED2 = 0; LED3 = 0; LED4 = 0; end
                    3'b01: begin LED2 = 1; LED3 = 0; LED4 = 0; end
                    3'b10: begin LED2 = 0; LED3 = 1; LED4 = 0; end
                    3'b11: begin LED2 = 0; LED3 = 0; LED4 = 1; end
                    
                    default: begin
                        LED2 = LED2; LED3 = LED3; LED4 = LED4;
                    end
                endcase

                  // 2'b1 OR 1????
            end
            
            SELLING: begin 
                if (stock1 == 3'b000) begin LED2 = 1'b1; end else begin LED2 = 1'b0; end
                if (stock2 == 3'b000) begin LED3 <= 1'b1; end else begin LED3 = 1'b0; end
                if (stock3 == 3'b000) begin LED4 = 1'b1; end else begin LED4 = 1'b0; end
            end
            
            default: begin
                LED2 = LED2; LED3 = LED3; LED4 = LED4;
            end
 
        endcase
    end

    always @(*) begin
        
        case(state)
        /* assign value for each MODE */
            ITEM_FILLING: begin
                case(val_sel)
                    2'b01: begin value = {4'b0000, stock1}; end
                    2'b10: begin value = {4'b0000, stock2}; end
                    2'b11: begin value = {4'b0000, stock3}; end
                endcase
            end    
            INSERT_COIN: begin 
                value = {1'b0, balance}; 
            end
            
            SELLING: begin
                value = {1'b0, balance};             
            end

        endcase
    end

    always @ (posedge clk or negedge resetn) begin
        /* assign val_sel for each MODE */
        btn = {btn1, btn2, btn3};
        
        if (resetn == 0) begin
            val_sel <= 0;
        end
        else begin
            case(btn)
                3'b100: begin
                    val_sel <= 2'b01;
                end
                3'b010: begin
                    val_sel <= 2'b10;
                end
                3'b001: begin
                    val_sel <= 2'b11;
                end
            endcase
        end
    end

    clk_wiz_0 Uclk_wiz( //this is the IP in VIVADO to make board-generated 100MHz clk to 5MHz clk ==> Never change
        .clk_out1   (clk_5MHz   ), // use this signal
        .resetn     (resetn     ),
        .clk_in1    (clk        )
    );

    clock_buffer Uclock_buffer(
        .resetn     (resetn     ),
        .clk_5MHz   (clk_5MHz   ), //from Uclk_wiz
        .clk_50Hz   (clk_50Hz   ) //used for cat signal in SSD
    );

    debouncer Udebouncer_1 (.clk(clk_50Hz), .in(btn1), .out(btn1_f));
    debouncer Udebouncer_2 (.clk(clk_50Hz), .in(btn2), .out(btn2_f));
    debouncer Udebouncer_3 (.clk(clk_50Hz), .in(btn3), .out(btn3_f));


    fsm_ctrlr Ufsm_ctrlr(
    .clk(clk_50Hz),
    .resetn(resetn),
    .sw3(sw3), .sw2(sw2), .sw1(sw1),
    .state_out(state)
    );

    coin_buffer Ucoin_buffer(
    .clk(clk_50Hz),
    .resetn(resetn),

    .state(state),
    .btn1(btn1_f), .btn2(btn2_f), .btn3(btn3_f),
    .stock1(stock1), .stock2(stock2), .stock3(stock3),
    .balance(balance)
    );

    item_buffer Uitem_buffer(
    .clk(clk_50Hz),
    .resetn(resetn),
    .state(state),
    .btn1(btn1_f), .btn2(btn2_f), .btn3(btn3_f),
    .balance(balance),

    .stock1(stock1), .stock2(stock2), .stock3(stock3)
    );

    ssd Ussd (
        .clk     ( clk_50Hz ),
        .resetn  ( resetn ),
    
        .cnt   ( value ),
        .aa      ( aa ),
        .ab      ( ab ),
        .ac      ( ac ),
        .ad      ( ad ),
        .ae      ( ae ),
        .af      ( af ),
        .ag      ( ag ),
        .cat     ( cat )
    );

endmodule

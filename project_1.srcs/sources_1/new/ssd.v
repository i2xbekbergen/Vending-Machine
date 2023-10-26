
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/04 11:00:40
// Design Name: 
// Module Name: ssd
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

module ssd(
    input wire clk,
    input wire resetn,
    input wire [9:0] cnt,
////////////////////////////////
    output wire aa,ab,ac,ad,ae,af,ag,
    output reg cat
);
    reg aa_h, aa_l;
    reg ab_h, ab_l;
    reg ac_h, ac_l;
    reg ad_h, ad_l;
    reg ae_h, ae_l;
    reg af_h, af_l;
    reg ag_h, ag_l;
    reg [3:0] tens;
    reg [7:0] ones;
    
    assign aa = (cat) ? aa_h : aa_l;
    assign ab = (cat) ? ab_h : ab_l;
    assign ac = (cat) ? ac_h : ac_l;
    assign ad = (cat) ? ad_h : ad_l;
    assign ae = (cat) ? ae_h : ae_l;
    assign af = (cat) ? af_h : af_l;
    assign ag = (cat) ? ag_h : ag_l;

    //You can reuse the code for Term_Project_1_1
    always @ (posedge clk, negedge resetn) begin
    /* fill */
        if(resetn == 0) begin
            //cnt <= 10'd0;
            ones <= 4'b0000;
            tens <= 8'b00000000;
        end else begin        
            // cnt < 10
            if (cnt < 7'b0001010) begin 
                ones <= cnt;
                tens <= 4'b0000;
            end
            // 9 < cnt < 20
            else if (cnt < 7'b0010100 && cnt > 7'b0001001) begin 
                ones <= cnt - 7'b0001010;
                tens <= 4'b0001;
            end
            // 19 < cnt < 30
            else if (cnt < 7'b0011110 && cnt > 7'b0010011) begin 
                ones <= cnt - 7'b0010100;
                tens <= 4'b0010;
            end
            // 29 < cnt < 40
            else if (cnt < 7'b0101000 && cnt > 7'b00011101) begin 
                ones <= cnt - 7'b0011110;
                tens <= 4'b0011;
            end
            // 39 < cnt < 50
            else if (cnt < 7'b0110010 && cnt > 7'b0100111) begin 
                ones <= cnt - 7'b0101000;
                tens <= 4'b0100;
            end
            // 49 < cnt < 60
            else if (cnt < 7'b0111100 && cnt > 7'b0110001) begin 
                ones <= cnt - 7'b0110010;
                tens <= 4'b0101;
            end
            // 59 < cnt < 70
            else if (cnt < 7'b1000110 && cnt > 7'b0111011) begin 
                ones <= cnt - 7'b0111100;
                tens <= 4'b0110;
            end
            // 69 < cnt < 80
            else if (cnt < 7'b1010000 && cnt > 7'b1000101) begin 
                ones <= cnt - 7'b1000110;
                tens <= 4'b0111;
            end
            // 79 < cnt < 90
            else if (cnt < 7'b1011010 && cnt > 7'b1001111) begin 
                ones <= cnt - 7'b1010000;
                tens <= 4'b1000;
            end
            // 89 < cnt < 100
            else if (cnt < 7'b1100100 && cnt > 7'b1011001) begin 
                ones <= cnt - 7'b1011010;
                tens <= 4'b1001;
            end
        end
        
    end
    
    always @(*) begin
        case (ones)
            7'b0000000: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1111110;
            end
            7'b0000001: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b0110000;
            end
            7'b0000010: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1101101;
            end
            7'b0000011: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1111001;
            end
            7'b0000100: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b0110011;
            end
            7'b0000101: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1011011;
            end
            7'b0000110: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1011111;
            end
            7'b0000111: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1110000;
            end
            7'b0001000: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1111111;
            end
            7'b0001001: begin
                {aa_l, ab_l, ac_l, ad_l, ae_l, af_l, ag_l} = 7'b1111011;
            end
        endcase
    end

    always @(*) begin
        case (tens)
            4'b0000: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1111110;
            end
            4'b0001: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b0110000;
            end
            4'b0010: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1101101;
            end
            4'b0011: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1111001;
            end
            4'b0100: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b0110011;
            end
            4'b0101: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1011011;
            end
            4'b0110: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1011111;
            end
            4'b0111: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1110000;
            end
            4'b1000: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1111111;
            end
            4'b1001: begin
            {aa_h, ab_h, ac_h, ad_h, ae_h, af_h, ag_h} = 7'b1111011;
            end
        endcase
    end
    
    always @ (posedge clk, negedge resetn) begin
        if (!resetn) begin
            cat <= 0;
        end
        else begin
            cat <= ~cat;
        end 
    end
endmodule

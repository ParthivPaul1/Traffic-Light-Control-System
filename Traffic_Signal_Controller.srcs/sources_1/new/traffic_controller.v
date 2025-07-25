`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 10:19:48
// Design Name: 
// Module Name: traffic_controller
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

module N_S_Signal(
    input [5:0] state,
    output r,
    output y,
    output g_s,
    output g_l,
    output g_r
    );
    assign r = state[2]|state[3]|state[4]|state[5];
    assign y = state[1];
    assign g_s = state[0];
    assign g_l = state[0];
    assign g_r = state[2];
endmodule

module E_W_Signal(
    input [5:0] state,
    output r,
    output y,
    output g_s,
    output g_l,
    output g_r
    );
    assign r = state[0]|state[1]|state[2]|state[5];
    assign y = state[4];
    assign g_s = state[3];
    assign g_l = state[3];
    assign g_r = state[5];
endmodule

module counter(
    input clk,
    input rst,
    input count_en,
    output reg [5:0] count
    );
    always@(posedge clk or negedge rst) begin
        if(!rst) count <= 59;
        else begin
            if(count == 0) count <= 59;
            else count <= count-1;
        end
    end
endmodule

module control_unit(
    input clk,
    input rst,
    input [5:0] count,
    output reg [5:0] state
    );
    reg [5:0] next_state;
    parameter s0 = 6'b000001;
    parameter s1 = 6'b000010;
    parameter s2 = 6'b000100;
    parameter s3 = 6'b001000;
    parameter s4 = 6'b010000;
    parameter s5 = 6'b100000;
    // Combinational
    always@(*) begin
        case(state)
            s0: begin
                if(count == 15) next_state = s1;
                else next_state = s0;
            end
            s1: begin
                if(count == 10) next_state = s2;
                else next_state = s1;
            end
            s2: begin
                if(count == 0) next_state = s3;
                else next_state = s2;
            end
            s3: begin
                if(count == 15) next_state = s4;
                else next_state = s3;
            end
            s4: begin
                if(count == 10) next_state = s5;
                else next_state = s4;
            end
            s5: begin
                if(count == 0) next_state = s0;
                else next_state = s5;
            end
            default: next_state = 6'b0;
        endcase
    end
    
    // Sequential
    always@(negedge clk or negedge rst) begin
        if(!rst) state <= s0;
        else state <= next_state;
    end
endmodule

module traffic_controller(
    input clk,
    input rst,
    output [5:0] timer,
    output [4:0] n2s_signal,
    output [4:0] s2n_signal,
    output [4:0] e2w_signal,
    output [4:0] w2e_signal
    );
    wire [5:0] state;
    N_S_Signal n2s(
        .state(state),
        .r(n2s_signal[0]),
        .y(n2s_signal[1]),
        .g_s(n2s_signal[2]),
        .g_l(n2s_signal[3]),
        .g_r(n2s_signal[4])
        );
    N_S_Signal s2n(
        .state(state),
        .r(s2n_signal[0]),
        .y(s2n_signal[1]),
        .g_s(s2n_signal[2]),
        .g_l(s2n_signal[3]),
        .g_r(s2n_signal[4])
        );
    E_W_Signal e2w(
        .state(state),
        .r(e2w_signal[0]),
        .y(e2w_signal[1]),
        .g_s(e2w_signal[2]),
        .g_l(e2w_signal[3]),
        .g_r(e2w_signal[4])
        );
    E_W_Signal w2e(
        .state(state),
        .r(w2e_signal[0]),
        .y(w2e_signal[1]),
        .g_s(w2e_signal[2]),
        .g_l(w2e_signal[3]),
        .g_r(w2e_signal[4])
        );
    counter Timer(
        .clk(clk),
        .rst(rst),
        .count_en(1'b1),
        .count(timer)
        );
    control_unit CU(
        .clk(clk),
        .rst(rst),
        .count(timer),
        .state(state)
        );
endmodule

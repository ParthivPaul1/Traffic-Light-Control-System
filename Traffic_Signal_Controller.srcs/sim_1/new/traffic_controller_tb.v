`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 22:07:47
// Design Name: 
// Module Name: traffic_controller_tb
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


module traffic_controller_tb;
    reg clk, rst;
    wire [5:0] timer;
    wire [4:0] n2s_signal;
    wire [4:0] s2n_signal;
    wire [4:0] e2w_signal;
    wire [4:0] w2e_signal;
    // Instantiation
    traffic_controller uut(
        .clk(clk),
        .rst(rst),
        .timer(timer),
        .n2s_signal(n2s_signal),
        .s2n_signal(s2n_signal),
        .e2w_signal(e2w_signal),
        .w2e_signal(w2e_signal)
        );
    // Initialisation
    initial begin
        clk = 1'b0;
        rst = 1'b0;
    end
    // Clock generation
    always #5 clk = ~clk;
    // Varying stimuli
    initial begin
        #3 rst = 1'b1;
        #2500 $finish;
    end
    // Monitoring
    initial begin
        $monitor("Timer=%d\tn2s_signal=%b\ts2n_signal=%b\te2w_signal=%b\tw2e_signal=%b\n", timer, n2s_signal, s2n_signal, e2w_signal, w2e_signal);
    end
endmodule

`timescale 1ns / 1ps

module fsm_upcounter_top(
    input clk,
    input reset,
    input [1:0] sw,
    output [3:0] fndCom,
    output [7:0] fndFont,
    output [1:0] led
    );

    wire [13:0] w_i_digit;
    wire w_run_on;
    wire w_clr_on;

    fsm_watch U_fsm_wawtch(
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .o_run_on(w_run_on),
        .o_clr_on(w_clr_on)
    );

    upcounter U_upcounter(
        .clk(clk),
        .reset(reset),
        .i_run_on(w_run_on),
        .i_clr_on(w_clr_on),
        .qout(w_i_digit)
    );

    FndController U_fndController(
        .clk(clk),
        .reset(reset),
        .digit(w_i_digit),
        // output
        .fndCom(fndCom),
        .fndFont(fndFont)
    );

    assign led[0] = w_run_on;
    assign led[1] = w_clr_on;

endmodule

`timescale 1ns / 1ps


module upcounter(
    input clk,
    input reset,
    input i_run_on,
    input i_clr_on,
    output [13:0] qout
    );
    wire w_clk_10hz;

   clockDivider U_ClkDiv(
    .clk(clk)      ,
    .reset(reset)    ,
    .o_clk(w_clk_10hz)
    );
    counter U_Counter(
        .clk  (w_clk_10hz)  ,
        .reset(reset)  ,
        .count(qout)
    );
endmodule

module clockDivider (
    input clk,
    input reset,
    output o_clk
);
    reg [$clog2(10_000_000)-1:0] r_counter;
    reg r_clk;

    assign o_clk = r_clk;

    always @(posedge clk,posedge reset) begin
        if(reset) begin
            r_counter <= 0;
            r_clk <= 1'b0;
        end else begin
            if(r_counter == 10_000_000 -1) begin
                // 100_000_000는 1초, 10_000_000는 10Hz
                r_counter <= 0;
                r_clk <= 1'b1;
            end else begin
                r_counter <= r_counter + 1;
                r_clk <= 1'b0;
            end
        end
    end
endmodule

module counter (
    input clk,
    input reset,
    input i_run_on,
    input i_clr_on,
    output [13:0] count
);
    reg [13:0] r_counter;
    assign count = r_counter;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            r_counter <= 0;
        end else begin
            if (i_run_on == 1 && i_clr_on == 0)begin
                if(r_counter == 10_000-1 || i_clr_on) begin
                    r_counter <= 0;
                end else if (i_run_on == 1) begin
                    r_counter <= r_counter + 1;
                end
            end else if(i_run_on == 0 && i_clr_on == 1) begin
                    r_counter <= 0;
            end
        end
    end
    
endmodule
`timescale 1ns / 1ps


module fsm_watch(
    input clk,
    input reset,
    input [1:0] sw,
    output led,
    output reg o_run_on,
    output reg o_clr_on
    );

     // state has 2 state
    reg state,next_state; //상태를 저장하는 레지스터
    parameter STP_MD = 2'b00;
    parameter RUN_MD = 2'b01; 
    parameter CLR_MD = 2'b10;

    // state register
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= STP_MD;
        end else begin
            state <= next_state;
        end
    end

    // next state Combination logic
    always @(*) begin
        case(state)
        STP_MD: begin
            if(sw[0] == 1'b1) 
                next_state = RUN_MD;
        end
        RUN_MD: begin
            if(sw[0] == 1'b0) 
                next_state = STP_MD;
        end
        CLR_MD: begin
            if(sw[1] == 1'b1)
                next_state = CLR_MD;
        end
        endcase
    end
    
    // Output Combinational logic
    always @(*) begin
        case(state)
        STP_MD: begin
            o_run_on <= 0;
        end
        RUN_MD: begin
            o_run_on <= 1;
        end
        CLR_MD: begin
            o_clr_on <= 1;
        end
        endcase
    end


endmodule

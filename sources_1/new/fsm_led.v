`timescale 1ns / 1ps

module fsm_led(
    input clk,
    input reset,
    input sw,
    output reg led
    );
    // currently state has 2 state
    reg state,next_state; //상태를 저장하는 레지스터
    parameter LED_OFF = 1'b0, LED_ON = 1'b1; // parameter는 #define과 비슷하다.

    // state register
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= LED_OFF;
        end else begin
            state <= next_state;
        end
    end

    // next state Combinational logic
    // No need to use clock
    always @(*) begin
        case (state)
        // input에 따라서 next_State가 변경된다.
            LED_OFF: begin
                if(sw == 1'b1) next_state = LED_ON;
                else next_state = LED_OFF;
            end
            LED_ON: begin
                if(sw == 1'b0) next_state = LED_OFF;
                else next_state = LED_ON;
            end 
        endcase
    end

    // Output Combinational Logic
    // 밀리머신인 경우임
    always @(*) begin
        case (state)
           LED_OFF: begin
                if(sw == 1'b1) led = 1'b1;
                else led = 1'b0;
            end
            LED_ON: begin
                if(sw == 1'b0) led = 1'b0;
                else led = 1'b1;
            end 
        endcase
    end
endmodule

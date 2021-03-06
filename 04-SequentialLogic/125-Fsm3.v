module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;

    reg [3:0] state;
    reg [3:0] next_state;

    // State transition logic
    always @(*) begin
        next_state[A] = (state[A] && (~in)) || (state[C] && (~in));
        next_state[B] = (state[A] && in) || (state[B] && in) || (state[D] && in);
        next_state[C] = (state[B] && (~in)) || (state[D] && (~in));
        next_state[D] = (state[C] && in);
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if(areset)
        begin
            state[A] <= 1'b1;
            state[B] <= 1'b0;
            state[C] <= 1'b0;
            state[D] <= 1'b0;
        end
        else 
        begin
            state <= next_state;
        end
    end
    // Output logic

    assign out = (state[D]);

endmodule

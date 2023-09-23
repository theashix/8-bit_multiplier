module add_subtractor(
    input logic     [8:0]   A, B,
    input logic             fn, add,
    output logic    [8:0]   S,
    output logic            carry_out
    );

    logic [8:0] internal_B, internal_S;
    
    always_comb begin
            internal_B = {9{fn}}^B;
    end
    
    ripple_adder RA9 (
        .x(A),
        .y(internal_B),
        .z(fn),
        .s(S),
        .cout(carry_out)
    );

endmodule

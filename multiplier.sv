module multiplier(
    input   logic           Clk, Reset_Load_Clear, Run,
    input   logic   [7:0]   SW,
    output  logic   [7:0]   hex_segA,
    output  logic   [3:0]   hex_gridA,
    output  logic   [7:0]   Aval, Bval,
    output  logic           Xval
);
    logic Run_SH_prev;
    logic Run_Rising_Edge;
    logic [7:0] A, B;
    logic [7:0] SW_S;
    logic [8:0] S;
    logic subtract, add, shift_en, shift_in, shift_out, Aout, Bout, X, carry_out;

    control Ctrl (
        .Clk,
        .Reset_Load_Clear(Reset_Load_Clear_SH),
        .Run(Run_Rising_Edge),
        .M(B[0]),
        .clr_ld,
        .shift_en,
        .add,
        .subtract
    );

    add_subtractor add_sub(
        .A({A[7],A}),
        .B({SW_S[7],SW_S[7:0]}),
        .fn(subtract),
        .add,
        .S,
        .carry_out
    );

    shift_register SRA (
        .Clk,
        .reset(clr_ld),
        .shift_in(X),
        .load(add),
        .shift_en,
        .D(S[7:0]),
        .shift_out(Aout),
        .Data_Out(A)
    );

    shift_register SRB (
        .Clk,
        .reset(1'b0),
        .shift_in(Aout),
        .load(Reset_Load_Clear_SH),
        .shift_en,
        .D(SW_S[7:0]),
        .shift_out(Bout),
        .Data_Out(B)
    );

    HexDriver HexA (
        .clk(Clk),
        .reset(Reset_Load_Clear_SH),
        .in({A[7:4], A[3:0], B[7:4], B[3:0]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );

     always_ff @(posedge Clk or posedge Reset_Load_Clear_SH) begin
        if (Reset_Load_Clear_SH)
            Run_SH_prev <= 1'b0;
        else
            Run_SH_prev <= Run_SH;
    end
    assign Run_Rising_Edge = Run_SH & ~Run_SH_prev;

    always_ff @ (posedge Clk)
     begin
        if (Reset_Load_Clear_SH)
            X <= 1'b0;
        else if (add)
            X <= S[8];
        else
            X <= X;
     end


    sync button_sync[1:0] (Clk, {Reset_Load_Clear, Run}, {Reset_Load_Clear_SH, Run_SH});
    sync SW_sync[7:0] (Clk, SW, SW_S);

    assign Aval = A[7:0];
    assign Bval = B[7:0];
    assign Xval = X;

endmodule
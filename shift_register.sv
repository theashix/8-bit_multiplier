module shift_register(
    input logic Clk, reset, shift_in, load, shift_en,
    input logic [7:0] D,
    output logic shift_out,
    output logic [7:0] Data_Out
    );

    always_ff @ (posedge Clk) begin
        if (reset)
            Data_Out <= 8'b0;
        else if (load)
            Data_Out <= D;
        else if (shift_en)
            Data_Out <= {shift_in, Data_Out[7:1]};
    end

    assign shift_out = Data_Out[0];

endmodule
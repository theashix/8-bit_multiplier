module ripple_adder ( input logic  [8:0] x, y,
                      input logic        z,
                      output logic [8:0] s,
                      output logic       cout);

logic [7:0] c;

    full_adder FA0(.x(x[0]), .y(y[0]), .z(z), .s(s[0]), .c(c[0]));
    full_adder FA1(.x(x[1]), .y(y[1]), .z(c[0]), .s(s[1]), .c(c[1]));
    full_adder FA2(.x(x[2]), .y(y[2]), .z(c[1]), .s(s[2]), .c(c[2]));
    full_adder FA3(.x(x[3]), .y(y[3]), .z(c[2]), .s(s[3]), .c(c[3]));
    full_adder FA4(.x(x[4]), .y(y[4]), .z(c[3]), .s(s[4]), .c(c[4]));
    full_adder FA5(.x(x[5]), .y(y[5]), .z(c[4]), .s(s[5]), .c(c[5]));
    full_adder FA6(.x(x[6]), .y(y[6]), .z(c[5]), .s(s[6]), .c(c[6]));
    full_adder FA7(.x(x[7]), .y(y[7]), .z(c[6]), .s(s[7]), .c(c[7]));
    full_adder FA8(.x(x[8]), .y(y[8]), .z(c[7]), .s(s[8]), .c(cout));

endmodule